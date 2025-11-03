import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/wallet_controller.dart';
import 'package:lekra/data/models/transaction_model.dart.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/dashboard/wallet/create_wallet_pin_screen/wallet_create_pin_screen.dart';
import 'package:lekra/views/screens/dashboard/wallet/wallet_screen/components/profile-balalnce_section.dart';
import 'package:lekra/views/screens/dashboard/wallet/wallet_screen/components/transaction_container.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isWallPinCreate = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<WalletController>().fetchWallet().then((value) {
        if (value.isSuccess) {
          Get.find<WalletController>().fetchWalletTransaction();
          setState(() {
            isWallPinCreate = false;
          });
        } else {
          Get.find<WalletController>().updatePage(WalletScreen());
          navigate(context: context, page: WalletCreatePinScreen());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: "Wallet",
        showBackButton: false,
      ),
      body: isWallPinCreate
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                      GetBuilder<WalletController>(builder: (walletController) {
                        return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final transactionModel =
                                  walletController.isLoading
                                      ? TransactionModel()
                                      : walletController.transactionList[index];
                              return CustomShimmer(
                                  isLoading: walletController.isLoading,
                                  child: TransactionsContainer(
                                    transactionModel: transactionModel,
                                  ));
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 12,
                              );
                            },
                            itemCount: walletController.isLoading
                                ? 1
                                : walletController.transactionList.length);
                      }),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
