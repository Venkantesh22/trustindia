import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/recharge_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';

class Success_top_section extends StatelessWidget {
  const Success_top_section({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RechargeController>(builder: (rechargeController) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: primaryColor.withValues(alpha: 0.50),
        ),
        padding: EdgeInsets.symmetric(horizontal: 38, vertical: 14),
        child: Column(
          children: [
            Text(
              "Processing Recharge of ₹ 349.00 ",
              style: Helper(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                CustomImage(
                  path: rechargeController.selectNetworkOperate?.logo ?? "",
                  height: 48,
                  width: 48,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jio",
                      style: Helper(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "7751958321",
                      style: Helper(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "₹ 349.00",
                      style: Helper(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
