import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/controllers/wallet_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/seleck_payment/seleck_payment_screen/component/row_of_upi_option.dart';
import 'package:lekra/views/screens/dashboard/wallet/wallet_enter_pin_screen/wallet_enter_pin_screen.dart';

class SelectPaymentScreen extends StatefulWidget {
  final bool isMemberShipPayment;
  final String totalAmount;
  
  const SelectPaymentScreen(
      {super.key, this.isMemberShipPayment = false, required this.totalAmount});

  @override
  State<SelectPaymentScreen> createState() => _SelectPaymentScreenState();
}

class _SelectPaymentScreenState extends State<SelectPaymentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<WalletController>().fetchWallet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "Select a payment method",
          style: Helper(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: black,
            )),
      ),
      body: GetBuilder<OrderController>(builder: (orderController) {
        return Stack(
          children: [
            Padding(
              padding: AppConstants.screenPadding,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        GetBuilder<WalletController>(
                            builder: (walletController) {
                          return GestureDetector(
                            onTap: () {
                              if (walletController.isLoading) {
                                return;
                              }
                              navigate(
                                  context: context,
                                  page: WalletEnterPinScreen(
                                    isMemberShipPayment:
                                        widget.isMemberShipPayment,
                                  ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomShimmer(
                                  isLoading: walletController.isLoading,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pay with Wallet",
                                        style: Helper(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Available balance: ${walletController.walletModel?.walletBalance}",
                                        style: Helper(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                                fontSize: 16,
                                                color: greyLight,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 12,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final upi = upiOptionList[index];
                              return RowOfUPIOption(
                                image: upi.image,
                                title: upi.title,
                                onTap: upi.onTap,
                              );
                            },
                            itemCount: upiOptionList.length)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsGeometry.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount",
                          style: Helper(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.totalAmount,
                          style: Helper(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (orderController.isLoading)
              Positioned.fill(
                child: Container(
                  color: black.withValues(alpha: 0.4),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
