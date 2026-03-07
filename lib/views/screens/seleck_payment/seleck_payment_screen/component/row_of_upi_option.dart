// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/dashboard_controller.dart';
import 'package:lekra/controllers/fund_request_controller.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/controllers/subscription_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/dashboard/dashboard_screen.dart';
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

List<UpiOptionModel> getUpiOptionList({bool isMemberShipPayment = false}) {
  return [
    UpiOptionModel(
      title: "Dynamic QR",
      onTap: (context) {
        navigate(
            context: context,
            page: QRPaymentScreen(
              isMemberShipPayment: isMemberShipPayment,
            ));
      },
    ),
    UpiOptionModel(
      image: Assets.imagesUpi,
      title: "Pay with Other UPI Apps",
      onTap: (context) async {
        if (isMemberShipPayment) {
          //* Payment for subscription

          final subscriptionController = Get.find<SubscriptionController>();

          final value = await subscriptionController.subscriptionCheckout(
            id: subscriptionController.selectSubscription?.id,
          );

          if (value.isSuccess) {
            showToast(message: value.message, typeCheck: true);

            Get.find<DashBoardController>().dashPage = 3;

            navigate(context: context, page: const DashboardScreen());
          } else {
            showToast(message: value.message, typeCheck: false);
          }

          return;
        } else {
          //* Payment for Product
          final orderController = Get.find<OrderController>();

          final value = await orderController.checkoutOrderIUPIntent(
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
