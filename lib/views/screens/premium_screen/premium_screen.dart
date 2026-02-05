import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/controllers/subscription_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/screens/premium_screen/components/premium_bottom_section.dart';
import 'package:lekra/views/screens/premium_screen/components/premium_medium_section.dart';
import 'package:lekra/views/screens/premium_screen/components/premium_top_section.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = Get.find<AuthController>();
      Get.find<SubscriptionController>().fetchSubscriptionPlanDetails(
          id: authController.userModel?.subscription?.subscriptionId ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              PremiumTopSection(),
              PremiumMediumSection(),
              PremiumBottomSection(),
            ],
          ),
        ),
      ),
    );
  }
}
