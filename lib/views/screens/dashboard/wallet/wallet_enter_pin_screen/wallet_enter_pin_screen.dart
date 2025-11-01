import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/order_screem/screen/order_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar_back_button.dart';

class WalletEnterPiniScreen extends StatefulWidget {
  const WalletEnterPiniScreen({super.key});

  @override
  State<WalletEnterPiniScreen> createState() => _WalletEnterPiniScreenState();
}

class _WalletEnterPiniScreenState extends State<WalletEnterPiniScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<OrderController>().walletPin = "";
      Get.find<OrderController>().update();
    });
  }

  void onKeyPress(String value, OrderController orderController) {
    if (value == 'back') {
      if (orderController.walletPin.isNotEmpty) {
        orderController.walletPin = orderController.walletPin
            .substring(0, orderController.walletPin.length - 1);
        orderController.update();
      }
    } else if (orderController.walletPin.length < 6) {
      orderController.walletPin += value;
      orderController.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) {
        final isComplete = orderController.walletPin.length == 6;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppbarBackButton(),
          body: SafeArea(
            child: Padding(
              padding: AppConstants.screenPadding,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const CustomImage(
                    path: Assets.imagesLocalBgGrey,
                    radius: 10,
                    width: 74,
                    height: 60,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Enter 6-Digit PIN",
                    style: Helper(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "This PIN secures your wallet and transactions.",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: greyBillText),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      6,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: index < orderController.walletPin.length
                              ? primaryColor
                              : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var row in [
                        ['1', '2', '3'],
                        ['4', '5', '6'],
                        ['7', '8', '9'],
                        ['', '0', 'back'],
                      ])
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8), // row gap
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: row.map((val) {
                              if (val.isEmpty) {
                                return const SizedBox(width: 102, height: 50);
                              } else if (val == 'back') {
                                return Container(
                                  width: 102,
                                  height: 50,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: IconButton(
                                    onPressed: () =>
                                        onKeyPress(val, orderController),
                                    icon: const Icon(
                                      Icons.backspace_outlined,
                                      size: 28,
                                      color: greyBillText,
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () =>
                                        onKeyPress(val, orderController),
                                    child: Container(
                                      width: 102,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: greyNumberBg,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        val,
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }).toList(),
                          ),
                        ),
                    ],
                  ),

                  const Spacer(),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    child:
                        GetBuilder<OrderController>(builder: (orderController) {
                      return ElevatedButton(
                        onPressed: isComplete
                            ? () {
                                Get.find<OrderController>()
                                    .postCheckout(
                                        addressId: Get.find<BasicController>()
                                            .selectAddress
                                            ?.id)
                                    .then(
                                  (value) {
                                    if (value.isSuccess) {
                                      Get.find<OrderController>()
                                          .postPayOrderWallet(
                                              orderId:
                                                  Get.find<OrderController>()
                                                      .orderId)
                                          .then((value) {
                                        if (value.isSuccess) {
                                          showToast(
                                              message: value.message,
                                              typeCheck: value.isSuccess);

                                          navigate(
                                              context: context,
                                              page: OrderScreen());
                                        } else {
                                          showToast(
                                              message: value.message,
                                              typeCheck: value.isSuccess);
                                        }
                                      });
                                    } else {
                                      showToast(
                                          message: value.message,
                                          typeCheck: value.isSuccess);
                                    }
                                  },
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          disabledBackgroundColor:
                              Colors.blue.withValues(alpha: 0.4),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
