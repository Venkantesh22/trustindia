import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/referral_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/drawer/drawer_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar_drawer.dart';

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
      Get.find<ReferralController>().fetchRewards();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        spreadRadius: 0,
                        offset: const Offset(0, 6))
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total Points",
                              style: Helper(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 14, color: grey)),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "${0} pts",
                            style: Helper(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: primaryColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.military_tech,
                        size: 50,
                        color: greyBorder,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: secondaryColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Text(
                          "View Rewards History",
                          style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                              color: secondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
