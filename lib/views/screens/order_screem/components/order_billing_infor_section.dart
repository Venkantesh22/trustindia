import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class OrderBillingInforSection extends StatelessWidget {
  const OrderBillingInforSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: greyBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Billing Information",
                style: Helper(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            buildBillingRow(
                "Name :",
                capitalize(orderController.selectOrder?.billingName ?? ""),
                greyDark,
                context),
            buildBillingRow(
                "Phone :",
                "+91 ${orderController.selectOrder?.billingPhone ?? ""}",
                greyDark,
                context),
            buildBillingRow(
                "Email :",
                orderController.selectOrder?.billingEmail ?? "",
                greyDark,
                context),
            GetBuilder<BasicController>(builder: (basicController) {
              return buildBillingRow(
                  "Address :",
                  basicController.orderAddress?.fullAddress ?? "",
                  greyDark,
                  context);
            }),
          ],
        ),
      );
    });
  }

  Widget buildBillingRow(
      String label, String value, Color muted, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(label,
              style: Helper(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: muted, fontSize: 14)),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(value,
                style: Helper(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500, fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
