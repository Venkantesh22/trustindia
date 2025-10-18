import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/data/models/transaction_model.dart.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/wallet_screen/components/profile-balalnce_section.dart';
import 'package:lekra/views/screens/wallet_screen/components/transaction_container.dart';
import 'package:lekra/views/screens/widget/custom_appbar2.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) {
      Get.find<BasicController>().fetchWalletTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: "Wallet",
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileBalanceSection(),
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Transactions",
                  style: Helper(context).textTheme.titleSmall?.copyWith(),
                ),
                const SizedBox(height: 12),
                GetBuilder<BasicController>(builder: (basicController) {
                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final transactionModel = basicController.isLoading
                            ? TransactionModel()
                            : basicController.transactionList[index];
                        return CustomShimmer(
                            isLoading: basicController.isLoading,
                            child: TransactionsContainer(
                              transactionModel: transactionModel,
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 12,
                        );
                      },
                      itemCount: basicController.isLoading
                          ? 1
                          : basicController.transactionList.length);
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
