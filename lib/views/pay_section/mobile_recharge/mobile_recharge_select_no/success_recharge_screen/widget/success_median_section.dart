import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/custom_image.dart';

class Success_median_section extends StatelessWidget {
  const Success_median_section({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CustomImage(
            path: Assets.imagesCheckMarkRecharge,
            height: 64,
            width: 64,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 24),
          Text(
            "Recharge Successful",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 17),
          Text(
            "Your Recharge of ₹ 349.00 to 7751958321 is successful. ",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 17),
          Text(
            "You've earned ₹ 0.87 reward cashback. ",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
