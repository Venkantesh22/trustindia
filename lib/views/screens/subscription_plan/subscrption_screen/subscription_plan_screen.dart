import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/subscription_controller.dart';
import 'package:lekra/data/models/subscription_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/drawer/drawer_screen.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_details_screen/subscription_details_screen.dart';
import 'package:lekra/views/screens/subscription_plan/subscrption_screen/components/subscription_container.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';
import 'package:page_transition/page_transition.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  final String? subscriptionPlanName;
  const SubscriptionPlanScreen({super.key, required this.subscriptionPlanName});

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SubscriptionController>().fetchSubscriptionPlanById();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      key: scaffoldKey,
      appBar: CustomAppBar2(title: widget.subscriptionPlanName ?? ""),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            GetBuilder<SubscriptionController>(
                builder: (subscriptionController) {
              return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final subscription = subscriptionController.isLoading
                        ? SubscriptionModel()
                        : subscriptionController.subscriptionList[index];
                    return CustomShimmer(
                      isLoading: subscriptionController.isLoading,
                      child: SubscriptionContainer(
                          onPressed: () {
                            if (subscriptionController.isLoading) {
                              return;
                            }
                            navigate(
                                type: PageTransitionType.rightToLeft,
                                context: context,
                                page: SubscriptionDetailsScreen(
                                  subscriptionId: subscription.id,
                                ));
                          },
                          subscription: subscription),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: subscriptionController.isLoading
                      ? 2
                      : subscriptionController.subscriptionList.length);
            })
          ],
        ),
      ),
    );
  }
}
