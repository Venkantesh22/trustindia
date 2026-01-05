import 'package:flutter/material.dart';
import 'package:lekra/data/models/subscription/subscription_history_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_history/subscription_history_screen/components/subscription_status_container.dart';

class SubscriptionHistoryWidget extends StatelessWidget {
  final SubscriptionHistoryModel subscriptionHistoryModel;
  const SubscriptionHistoryWidget({
    super.key,
    required this.subscriptionHistoryModel,
  });

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
                subscriptionHistoryModel.planName ?? "",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                subscriptionHistoryModel.discountPriceFormat,
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
                  subscriptionHistoryModel.startDateFormat,
                  style: Helper(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 12,
                        color: greyMember,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SubscriptionStatusContainer(
                  isActive: subscriptionHistoryModel.isActive,
                )
              ],
            ),
          ),
          Text(
            "Basic Membership for ${subscriptionHistoryModel.startDateFormat}-${subscriptionHistoryModel.endDateFormat}",
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
