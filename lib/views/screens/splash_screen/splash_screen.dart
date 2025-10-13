import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lekra/views/screens/auth_screens/login_screen.dart';

import '../../../services/constants.dart';
import '../../base/custom_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

  //  Get.find<BasicController>().fetchSettings().then((value) async {
  //     if (value.isSuccess) {
  //       PackageInfo info = await PackageInfo.fromPlatform();
  //       log(info.buildNumber, name: 'Build Number');
  //       log(info.version, name: 'Version');

  //       if ((Platform.isIOS ? Get.find<BasicController>().settings?.iosAppVersion : Get.find<BasicController>().settings?.appVersion).toInt > info.buildNumber.toInt) {
  //         if (!mounted) return;
  //         await showUpdateDialogue(
  //           context: context,
  //           skip: (Platform.isAndroid
  //               ? (Get.find<BasicController>().settings?.forceUpdate != 'on')
  //               : (Get.find<BasicController>().settings?.iosForceUpdate != 'on')),
  //         );
  //       } else if ((Platform.isAndroid ? Get.find<BasicController>().settings?.maintenanceMode : Get.find<BasicController>().settings?.iosMaintenanceMode) == 'on') {
  //         if (!mounted) return;
  //         await showMaintenanceDialog(
  //           context: context,
  //         );
  //       }

  //       // Without Login Explore
  //       Timer(const Duration(seconds: 2), () {
  //         if (Get.find<AuthController>().isLoggedIn()) Get.find<AuthController>().getUserProfileData();
  //         if (Get.find<SharedPreferences>().getBool(AppConstants.isFirstVisit) ?? true) {
  //           Navigator.pushReplacement(
  //             context,
  //             getCustomRoute(
  //               child: const IntroScreen(),
  //             ),
  //           );
  //         } else {
  //           Navigator.pushReplacement(
  //             context,
  //             getCustomRoute(
  //               child: const DashboardScreen(),
  //             ),
  //           );
  //         }
  //       });

  //     } else {
  //       showCustomToast(msg: value.data?.toString() ?? 'Something Went Wrong');
  //     }
  //   });

    Timer.run(() {
      Future.delayed(const Duration(seconds: 2), () {});
      // if (Get.find<AuthController>().isLoggedIn()) {
      //   Get.find<AuthController>().getUserProfileData().then((value) {
      //     Future.delayed(const Duration(seconds: 2), () {
      //       if (Get.find<AuthController>().checkUserData()) {
      //         Navigator.pushReplacement(
      //           context,
      //           getMaterialRoute(
      //             child: const Dashboard(),
      //           ),
      //         );
      //       } else {
      //         Navigator.pushReplacement(
      //           context,
      //           getMaterialRoute(
      //             child: const SignupScreen(),
      //           ),
      //         );
      //       }
      //     });
      //   });
      // } else {
        // Navigator.pushReplacement(
        //   context,
        //   getMaterialRoute(
        //     child: const LoginScreen(),
        //   ),
        // );
      // }
    });
  }
  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2)); // splash delay

    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   // Already signed in
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (_) => MainScreen(0)),
    //   );
    // } else {
      
      // Not signed in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    // }
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
