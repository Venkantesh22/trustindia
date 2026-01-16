import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/custom_image.dart';

class RechargeAndBillsSection extends StatelessWidget {
  const RechargeAndBillsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recharge & Bills",
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          GridView.builder(
              padding: EdgeInsets.only(top: 20),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 6,
                crossAxisSpacing: 15,
                childAspectRatio: 0.75,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomImage(
                      path: Assets.imagesRechargeDemo,
                      height: 56,
                      width: 56,
                      radius: 100,
                    ),
                    Text(
                      "Mobile Recharge",
                      textAlign: TextAlign.center,
                      style: Helper(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                    )
                  ],
                );
              })
        ],
      ),
    );
  }
}
