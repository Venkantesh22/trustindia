import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/rewards/screen/reward_history_screen/reward_history_screen.dart';

class TotalPointSection extends StatelessWidget {
  const TotalPointSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: black.withValues(alpha: 0.1),
                blurRadius: 6,
                spreadRadius: 0,
                offset: const Offset(0, 6))
          ]),
      child: Column(
        children: [
          GetBuilder<AuthController>(builder: (authController) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Coins",
                        style: Helper(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 14, color: grey)),
                    const SizedBox(height: 4),
                    Text(
                      "${authController.userModel?.rewardPoint ?? ""} coins",
                      style: Helper(context).textTheme.titleSmall?.copyWith(
                          color: primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Icon(
                  Icons.military_tech,
                  size: 50,
                  color: greyBorder,
                )
              ],
            );
          }),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              navigate(context: context, page: const RewardHistoryScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "10 coins = ₹ 1",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: secondaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Text(
                    "View Rewards History",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        color: secondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
