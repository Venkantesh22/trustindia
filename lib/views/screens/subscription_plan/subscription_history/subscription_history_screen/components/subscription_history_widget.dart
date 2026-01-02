import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_history/subscription_history_screen/components/subscription_status_container.dart';

class SubscriptionHistoryWidget extends StatelessWidget {
  const SubscriptionHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
          border: Border.all(
            color: black.withValues(alpha: 0.17),
          ),
          borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Basic Membership",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                "₹199",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: primaryColor),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "29/11/2025",
                  style: Helper(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 12,
                        color: greyMember,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SubscriptionStatusContainer()
              ],
            ),
          ),
          Text(
            "Basic Membership for 29/11/2025-29/12/2025",
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 12,
                  color: greyAccountText,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
