// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/firebase/block_screen.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/auth_screens/forget_password/opt_verification_screen.dart';
import 'package:lekra/views/screens/auth_screens/login_screen.dart';
import 'package:lekra/views/screens/dashboard/dashboard_screen.dart';
import 'package:lekra/views/screens/demo/screen/demo_dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAuth();
    });
  }

  Future<void> checkAuth() async {
    final basicController = Get.find<BasicController>();
    await basicController.isCheckApp();

    bool isBlock = basicController.blockModel?.isBlock ?? false;
    bool isTimeBlock = basicController.blockModel?.timeBlock ?? false;
    log("isBlock == $isBlock,  isTimeBlock == $isTimeBlock  ");

    // 🔴 If both true
    if (isBlock && isTimeBlock) {
      navigate(
        context: context,
        page: FlashMessageScreen(),
        isRemoveUntil: true,
      );
      return;
    }

    // 🔴 Permanent block
    if (isBlock) {
      navigate(
        context: context,
        page: FlashMessageScreen(),
        isRemoveUntil: true,
      );
      return;
    }

    // 🟡 Time-based random close
    if (isTimeBlock) {
      basicController.startRandomCloseTimer();
    }

    await Future.delayed(const Duration(seconds: 2));
    final authController = Get.find<AuthController>();

    String token = authController.getUserToken();

    final sharedPreferences = await SharedPreferences.getInstance();

    await authController.fetchUserProfile();
    if (authController.userModel?.isPhoneVerified == false) {
      navigate(
          context: context,
          page: OTPVerification(
            phone: authController.userModel?.mobile ?? "",
            isVerificationPhone: true,
          ),
          isRemoveUntil: true);
      showToast(
          message: "Verified phone number to container..",
          toastType: ToastType.warning);
      return;
    }

    bool isDemoShow =
        sharedPreferences.getBool(AppConstants.isDemoShowKey) ?? false;

    if (token.isNotEmpty) {
      final response = await authController.fetchUserProfile();

      if (response.isSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      } else {
        authController.logout();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        isDemoShow
            ? MaterialPageRoute(builder: (_) => const LoginScreen())
            : MaterialPageRoute(builder: (_) => const DemoDashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            CustomImage(
              alignment: Alignment.center,
              path: Assets.imagesOnlyLogo,
              height: size.height * 0.3,
              width: size.height * 0.3,
            ),
            const Spacer(flex: 3),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 26.0,
                  ),
            ),
            // Text(
            //   "Subtitle",
            //   style: Theme.of(context).textTheme.bodyMedium,
            // ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
