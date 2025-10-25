import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/referral_controller.dart';
import 'package:lekra/data/models/scratch_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/drawer/drawer_screen.dart';
import 'package:lekra/views/screens/rewards/component/scratch_card_widget.dart';
import 'package:lekra/views/screens/rewards/component/total_point_section.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar_drawer.dart';
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
      Get.find<ReferralController>().fetchScratchCard();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerScreen(),
      appBar:
          CustomAppbarDrawer(scaffoldKey: scaffoldKey, title: "Your Rewards"),
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
            GetBuilder<ReferralController>(builder: (referralController) {
              if (referralController.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (referralController.scratchCardList.isEmpty) {
                return const Center(child: Text("No scratch cards available."));
              }
              return GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: referralController.scratchCardList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (context, index) {
                  final scratchCardModel = referralController.isLoading
                      ? const ScratchCardModel()
                      : referralController.scratchCardList[index];
                  return GestureDetector(
                    onTap: () {
                      scratchFun(context, scratchCardModel);
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
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Scratcher(
              image: Image.asset(
                Assets.imagesScratch,
                fit: BoxFit.contain,
              ),
              accuracy: ScratchAccuracy.medium,
              brushSize: 50,
              threshold: 30,
              onThreshold: () {},
              child: Container(
                height: 300,
                width: 300,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      scratchCardModel.isDiscount
                          ? "🎉 You've won a Discount!"
                          : "🎁 You've won!",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withValues(alpha: 0.9),
                            fontSize: 14,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      scratchCardModel.isDiscount
                          ? "${scratchCardModel.rewardPoints} OFF"
                          : "${scratchCardModel.rewardPoints} Points",
                      style: Helper(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        shadows: const [
                          Shadow(
                            color: white,
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
