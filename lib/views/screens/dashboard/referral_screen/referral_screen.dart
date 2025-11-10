import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/controllers/reward_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/dashboard/referral_screen/components/referral_tree.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';
import 'package:share_plus/share_plus.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RewardsController>().fetchReferral();
    });
  }

  bool useLevelView = false;

  void copyReferralCode(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
  }

  void shareReferralCode(String code, String? link) {
    String message = "Use my referral code: $code";

    // If there's a referral link, append it to the message
    if (link != null && link.isNotEmpty) {
      message += "\n$link";
    }

    SharePlus.instance.share(ShareParams(
      text: message,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: "Referral Structure",
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            // Top user info card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: GetBuilder<AuthController>(builder: (authController) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: CustomImage(
                        width: 90,
                        height: 90,
                        radius: 45,
                        path: authController.userModel?.image ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      capitalize(authController.userModel?.name ?? ""),
                      style: Helper(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      authController.userModel?.referralCode ?? "",
                      style: Helper(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => copyReferralCode(context,
                              authController.userModel?.referralCode ?? ""),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          icon: const Icon(Icons.copy, size: 18),
                          label: const Text("Copy"),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () => shareReferralCode(
                              authController.userModel?.referralCode ?? "",
                              authController.userModel?.referralLink ?? ""),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          icon: const Icon(Icons.share, size: 18, color: white),
                          label: Text(
                            "Share",
                            style: Helper(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: white),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 16),

            GetBuilder<RewardsController>(builder: (referralController) {
              if (referralController.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return CustomShimmer(
                isLoading: referralController.isLoading,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child:
                      ReferralGraphTree(roots: referralController.referralList),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
