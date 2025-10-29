import 'package:flutter/material.dart';
import 'package:lekra/data/models/subscription_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/dashboard/profile_screen/profile_screen.dart';

class SubscriptionContainer extends StatelessWidget {
  const SubscriptionContainer({
    super.key,
    required this.subscription,
  });

  final SubscriptionModel? subscription;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: greyBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subscription?.name ?? "",
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
          const SizedBox(
            height: 6,
          ),
          RichText(
            text: TextSpan(
              text: subscription?.priceFormat,
              style: Helper(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: " /month",
                  style: Helper(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ProfileButton(title: "Choose Plan", onPressed: () {}, color: black)
        ],
      ),
    );
  }
}
