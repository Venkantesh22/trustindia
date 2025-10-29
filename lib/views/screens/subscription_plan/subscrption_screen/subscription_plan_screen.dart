import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/subscription_controller.dart';
import 'package:lekra/data/models/subscription_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/drawer/drawer_screen.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_details_screen/subscription_details_screen.dart';
import 'package:lekra/views/screens/subscription_plan/subscrption_screen/components/subscription_container.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar_drawer.dart';

class SubscriptionPlan extends StatefulWidget {
  const SubscriptionPlan({super.key});

  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SubscriptionController>().fetchSubscriptionPlan();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      key: scaffoldKey,
      appBar: CustomAppbarDrawer(
        scaffoldKey: scaffoldKey,
        title: "Subscription Plans",
      ),
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
                      child: GestureDetector(
                          onTap: () {
                            if (subscriptionController.isLoading) {
                              return;
                            }
                            navigate(
                                context: context,
                                page: SubscriptionDetailsScreen(
                                  subscriptionId: subscription.id,
                                ));
                          },
                          child: SubscriptionContainer(
                              subscription: subscription)),
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
