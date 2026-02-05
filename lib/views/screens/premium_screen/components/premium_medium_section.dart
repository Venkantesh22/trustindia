import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/subscription_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';

class PremiumMediumSection extends StatelessWidget {
  const PremiumMediumSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(
        builder: (subscriptionController) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.fromLTRB(14, 18, 12, 22),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 25),
                blurRadius: 25,
                spreadRadius: 0,
                color: black.withValues(alpha: 0.10)),
            BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 10,
                spreadRadius: 0,
                color: black.withValues(alpha: 0.10))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomImage(
              path: Assets.imagesCureentBenefit,
              height: 64,
              width: 64,
            ),
            const SizedBox(width: 23),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Aligns text to the left
                mainAxisSize: MainAxisSize.min, // Takes only needed height
                children: [
                  Text(
                    "Special benefit update!",
                    style: Helper(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 5),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final feature = subscriptionController
                          .selectSubscription?.features?[index];
                      return SizedBox(
                        height: 20,
                        child: Text(
                          feature ?? "",
                          style: Helper(context).textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 6),
                    itemCount: subscriptionController
                            .selectSubscription?.features?.length ??
                        0,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
