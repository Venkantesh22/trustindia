import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/referral_controller.dart';
import 'package:lekra/data/models/reward_transaction_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/reward_history_screen/components/reward_history_profile_section.dart';
import 'package:lekra/views/screens/reward_history_screen/components/reward_trans_container.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class RewardHistoryScreen extends StatefulWidget {
  const RewardHistoryScreen({super.key});

  @override
  State<RewardHistoryScreen> createState() => _RewardHistoryScreenState();
}

class _RewardHistoryScreenState extends State<RewardHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ReferralController>().fetchRewardsWallerHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Rewards History"),
      body: GetBuilder<ReferralController>(builder: (referralController) {
        return SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              const RewardHistoryProfileSection(),
              SizedBox(
                height: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Transactions",
                    style: Helper(context).textTheme.titleSmall?.copyWith(),
                  ),
                  const SizedBox(height: 12),
                  GetBuilder<ReferralController>(builder: (referralController) {
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final rewardsTransaction = referralController
                                  .isRewardHistoryLoading
                              ? RewardsTransactionModel()
                              : referralController.rewardTransactionList[index];
                          return CustomShimmer(
                            isLoading:
                                referralController.isRewardHistoryLoading,
                            child: RewardTransContainer(
                              rewardsTransactionModel: rewardsTransaction,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 12,
                          );
                        },
                        itemCount: referralController.isRewardHistoryLoading
                            ? 1
                            : referralController.rewardTransactionList.length);
                  }),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
