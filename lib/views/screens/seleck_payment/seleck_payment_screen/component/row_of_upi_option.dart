// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/fund_request_controller.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/controllers/subscription_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/fund_requent_qr/dynamic_qr_sheet.dart';
import 'package:lekra/views/screens/seleck_payment/dynamc_qr_screen/dynamic_qr_screen.dart';

class RowOfUPIOption extends StatelessWidget {
  final String? image;
  final String title;
  final Function(BuildContext)? onTap;

  const RowOfUPIOption({
    super.key,
    this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                image != null
                    ? Row(
                        children: [
                          CustomImage(
                            path: image ?? "",
                            height: 26,
                            width: 26,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8),
                        ],
                      )
                    : const SizedBox(),
                Text(
                  title,
                  style: Helper(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}

class UpiOptionModel {
  final String? image;
  final String title;
  final Function(BuildContext)? onTap;

  UpiOptionModel({this.image, required this.title, required this.onTap});
}

List<UpiOptionModel> getUpiOptionList({
  bool isSubscriptionPayment = false,
  bool isOrderValueLessThen10 = false,
}) {
  return [
    UpiOptionModel(
      title: "Dynamic QR",
      onTap: (context) {
        navigate(
            context: context,
            page: QRPaymentScreen(
              isMemberShipPayment: isSubscriptionPayment,
            ));
      },
    ),
    UpiOptionModel(
      image: Assets.imagesUpi,
      title: "Pay with Other UPI Apps",
      onTap: (context) async {
        // log(" check 2 isOrderValueLessThan10 == $isOrderValueLessThen10");

        if (isOrderValueLessThen10 == true) {
          log("Order amount less than ₹10");

          showToast(
            message: "Order value must be ₹10 or more.",
            toastType: ToastType.error,
          );

          return; // stop execution
        }

        final orderController = Get.find<OrderController>();
        if (isSubscriptionPayment) {
          //* Payment for subscription

          final subscriptionController = Get.find<SubscriptionController>();
          log("check ---- isSubscriptionPayment : $isSubscriptionPayment , selectSubscription : ${subscriptionController.selectSubscription?.id} ");

          final value =
              await orderController.checkoutOrderIUPIntentSubscriptionPayment(
            subscriptionId: subscriptionController.selectSubscription?.id,
          );
          if (value.isSuccess) {
            DynamicQrSheet.show(context);

            Get.find<FundRequestController>().startPaymentFlow(
                context: context,
                isCheckoutPaymentForSubscription: isSubscriptionPayment);
          } else {
            showToast(message: value.message, typeCheck: false);
          }
          return;
        } else {
          //* Payment for Product

          final value =
              await orderController.checkoutOrderIUPIntentProductPayment(
            orderId: orderController.orderId,
          );

          if (value.isSuccess) {
            DynamicQrSheet.show(context);

            Get.find<FundRequestController>()
                .startPaymentFlow(context: context, isCheckPayment: true);
          } else {
            showToast(message: value.message, typeCheck: false);
          }
        }
      },
    ),
  ];
}
