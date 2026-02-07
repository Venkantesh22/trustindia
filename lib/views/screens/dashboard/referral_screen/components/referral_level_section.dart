import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lekra/controllers/referral_controller.dart';
import 'package:lekra/data/models/referral/referral_level_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/dashboard/referral_screen/components/referral_level_container.dart';

class ReferralLevelSection extends StatelessWidget {
  const ReferralLevelSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Row(
          children: [
            GetBuilder<ReferralController>(builder: (referralController) {
              return Expanded(
                child: CustomShimmer(
                  isLoading: referralController.isLoading,
                  child: Text(
                    "Team Levels : ${referralController.referralLevelModelList.length}",
                    overflow: TextOverflow.clip,
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                  ),
                ),
              );
            }),
            CustomButton(
              onTap: () {},
              color: secondaryColor,
              borderColor: secondaryColor,
              child: Text(
                "Graph View",
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700, fontSize: 14, color: white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        /// Make the list scrollable
        Expanded(
          // This gives ListView a bounded height
          child: GetBuilder<ReferralController>(
            builder: (referralController) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 8),
                itemCount: referralController.isLoading
                    ? 4
                    : referralController.referralLevelModelList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final referralLevelModel = referralController.isLoading
                      ? ReferralLevelModel()
                      : referralController.referralLevelModelList[index];
                  return CustomShimmer(
                    isLoading: referralController.isLoading,
                    child: ReferralLevelContainer(
                      referralLevelModel: referralLevelModel,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
