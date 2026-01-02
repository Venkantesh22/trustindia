
import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class SubscriptionDetailsMedianSection extends StatelessWidget {
  const SubscriptionDetailsMedianSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: whiteBg2,
        border: Border.all(color: grey.withValues(alpha: 0.50)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subscriptions Service Period",
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: 7),
          Text(
            "Basic Membership for 29/11/2025-29/12/2025",
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: greyAccountText),
          ),
        ],
      ),
    );
  }
}
