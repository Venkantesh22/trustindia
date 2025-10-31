import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/views/screens/auth_screens/login_screen.dart';
import 'package:lekra/views/screens/dashboard/dashboard_screen.dart';

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
    checkAuth(); // <-- Call here
  }

  // Future<void> checkAuth() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   final authController = Get.find<AuthController>();
  //   log("splash screen");
  //   String token = authController.getUserToken();

  //   if (token.isNotEmpty) {
  //     // User is signed in → go to HomeScreen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const DashboardScreen()),
  //     );
  //   } else {
  //     // User not signed in → go to LoginScreen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const LoginScreen()),
  //     );
  //   }
  // }
  Future<void> checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    final authController = Get.find<AuthController>();
    String token = authController.getUserToken();

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
        MaterialPageRoute(builder: (_) => const LoginScreen()),
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
            // CustomImage(
            //   path: Assets.imagesLogo,
            //   height: size.height * .3,
            //   width: size.height * .3,
            // ),
            const Spacer(flex: 3),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 26.0,
                  ),
            ),
            Text(
              "Subtitle",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
