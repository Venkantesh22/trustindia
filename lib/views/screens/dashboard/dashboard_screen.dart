import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lekra/views/screens/dashboard/account_screen/account_screen.dart';
import 'package:lekra/views/screens/dashboard/home_screen/home_screen.dart';
import 'package:lekra/views/screens/dashboard/referral_screen/referral_screen.dart';
import 'package:lekra/views/screens/dashboard/wallet/wallet_screen/wallet_screen.dart';
import 'package:lekra/views/screens/order_screem/screen/order_screen.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../../generated/assets.dart';
import '../../../services/theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        Get.find<DashBoardController>().dashPage = 0;
        // Show Exit Dialog
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // Returns true
                child: const Text('Yes'),
              ),
            ],
          ),
        );

        if (shouldExit == true) {
          // Close the app
          if (context.mounted) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        body: GetBuilder<DashBoardController>(
          builder: (DashBoardController controller) {
            return [
              const HomeScreen(),
              const WalletScreen(),
              const OrderScreen(),
              const ReferralScreen(),
              const AccountScreen(),
            ][controller.dashPage];
          },
        ),
        bottomNavigationBar: GetBuilder<DashBoardController>(
          builder: (DashBoardController controller) {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: backgroundLight,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomNavigationItemWidget(
                      onTap: () {
                        controller.dashPage = 0;
                      },
                      title: 'Home',
                      icon: Assets.svgsHome,
                      isActive: controller.dashPage == 0 ? true : false,
                    ),
                    BottomNavigationItemWidget(
                      onTap: () {
                        controller.dashPage = 1;
                      },
                      title: 'Wallet',
                      icon: Assets.svgsWallet,
                      isActive: controller.dashPage == 1 ? true : false,
                    ),
                    BottomNavigationItemWidget(
                      onTap: () {
                        controller.dashPage = 2;
                      },
                      title: 'Order',
                      icon: Assets.svgsShopping,
                      isActive: controller.dashPage == 2 ? true : false,
                    ),
                    BottomNavigationItemWidget(
                      onTap: () {
                        controller.dashPage = 3;
                      },
                      title: 'Referral ',
                      icon: Assets.svgsReferral,
                      isActive: controller.dashPage == 3 ? true : false,
                    ),
                    BottomNavigationItemWidget(
                      onTap: () {
                        controller.dashPage = 4;
                      },
                      title: 'Account',
                      icon: Assets.svgsProfile,
                      isActive: controller.dashPage == 4 ? true : false,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

///
class BottomNavigationItemWidget extends StatelessWidget {
  const BottomNavigationItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.isActive = false,
    this.onTap,
  });

  final String title;
  final String icon;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              icon,
              width: icon.contains('logout') ? 20 : 24,
              height: icon.contains('logout') ? 20 : 24,
              colorFilter: ColorFilter.mode(
                  isActive ? primaryColor : Colors.black87, BlendMode.srcIn),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isActive ? primaryColor : const Color(0xFF393648),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
