import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/reward_controller.dart';
import 'package:lekra/data/models/scratch_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/rewards/screen/reward_details_screen/reward_details_screen.dart';
import 'package:lekra/views/screens/rewards/screen/rewards_screen/component/scratch_card_widget.dart';
import 'package:lekra/views/screens/rewards/screen/rewards_screen/component/total_point_section.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';
import 'package:scratcher/scratcher.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RewardsController>().fetchScratchCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Rewards"),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TotalPointSection(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Scratch & Win",
                style: Helper(context).textTheme.titleSmall,
              ),
            ),
            GetBuilder<RewardsController>(builder: (rewardController) {
              if (rewardController.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (rewardController.scratchCardList.isEmpty) {
                return const Center(child: Text("No scratch cards available."));
              }
              return GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rewardController.scratchCardList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (context, index) {
                  final scratchCardModel = rewardController.isLoading
                      ? const ScratchCardModel()
                      : rewardController.scratchCardList[index];
                  return GestureDetector(
                    onTap: () {
                      if (rewardController.isLoading) {
                        showToast(
                            message: "Please Wait....",
                            toastType: ToastType.info);
                        return;
                      } else if (scratchCardModel.isScratch == false) {
                        scratchFun(context, scratchCardModel);
                      } else if (scratchCardModel.isScratch == true) {
                        navigate(
                            context: context,
                            page: RewardDetailsScreen(
                                scratchCardModel: scratchCardModel));
                      }
                    },
                    child: ScratchCardWidget(
                      scratchCardModel: scratchCardModel,
                    ),
                  );
                },
              );
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<dynamic> scratchFun(
      BuildContext context, ScratchCardModel scratchCardModel) {
    final scratchKey = GlobalKey<ScratcherState>();

    return showDialog(
      context: context,
      builder: (context) {
        return GetBuilder<RewardsController>(builder: (referralController) {
          return Dialog(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Scratcher(
              key: scratchKey,
              image: Image.asset(
                Assets.imagesScratch,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              accuracy: ScratchAccuracy.medium,
              brushSize: 50,
              threshold: 40,
              onThreshold: () {
                scratchKey.currentState
                    ?.reveal(duration: const Duration(seconds: 1));

                referralController
                    .postScratchCardRedeem(scratchId: scratchCardModel.id)
                    .then((value) {
                  if (value.isSuccess) {
                    pop(context);
                  }
                });
                Get.snackbar(
                  "Revealed!",
                  scratchCardModel.isDiscount
                      ? "You’ve unlocked ${scratchCardModel.rewardPoints} OFF 🎉"
                      : "You’ve won ${scratchCardModel.rewardPoints} Coins 🎁",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.black87,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      scratchCardModel.isDiscount
                          ? "🎉 Congratulation You've won a Discount!"
                          : "🎁 Congratulation You've won!",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withValues(alpha: 0.9),
                            fontSize: 14,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            scratchCardModel.isDiscount
                                ? "${scratchCardModel.rewardPoints} OFF"
                                : "${scratchCardModel.rewardPoints} Coins",
                            overflow: TextOverflow.ellipsis,
                            style:
                                Helper(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Colors.black,
                              shadows: const [
                                Shadow(
                                  color: Colors.white,
                                  offset: Offset(1, 1),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
