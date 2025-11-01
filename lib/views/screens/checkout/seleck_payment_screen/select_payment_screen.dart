import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/checkout/seleck_payment_screen/component/row_of_upi_option.dart';
import 'package:lekra/views/screens/dashboard/wallet/wallet_enter_pin_screen/wallet_enter_pin_screen.dart';
import 'package:lekra/views/screens/order_screem/screen/order_screen.dart';

class SelectPaymentScreen extends StatefulWidget {
  final bool isMemberShip;
  const SelectPaymentScreen({super.key, this.isMemberShip = false});

  @override
  State<SelectPaymentScreen> createState() => _SelectPaymentScreenState();
}

class _SelectPaymentScreenState extends State<SelectPaymentScreen> {
  void wallPay() {
    if (widget.isMemberShip) {
      // Get.find<SubscriptionController>().subscriptionCheckout(id: id)
    } else {}
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
                        GestureDetector(
                          onTap: () => navigate(
                              context: context, page: WalletEnterPiniScreen()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  GetBuilder<AuthController>(
                                      builder: (authController) {
                                    return Text(
                                      "Available balance: ${PriceConverter.convertToNumberFormat(authController.userModel?.currentWallet ?? 0.0)}",
                                      style: Helper(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontSize: 16,
                                              color: greyLight,
                                              fontWeight: FontWeight.w500),
                                    );
                                  }),
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded)
                            ],
                          ),
                        ),
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
                        GetBuilder<ProductController>(
                            builder: (productController) {
                          return Text(
                            productController.cardModel?.totalPriceFormat ?? "",
                            style: Helper(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                          );
                        })
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
