import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class SubscriptionStatusContainer extends StatelessWidget {
  const SubscriptionStatusContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(20)),
      child: Text(
        "Active",
        style: Helper(context).textTheme.bodyLarge?.copyWith(
              fontSize: 12,
              color: white,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
