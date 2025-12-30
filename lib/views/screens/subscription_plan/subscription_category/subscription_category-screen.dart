import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/subscription_controller.dart';
import 'package:lekra/data/models/subscription_cate_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_category/component/subscription_category_container.dart';
import 'package:lekra/views/screens/subscription_plan/subscrption_screen/subscription_plan_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar_drawer.dart';
import 'package:page_transition/page_transition.dart';

class SubscriptionCategoryPlan extends StatefulWidget {
  const SubscriptionCategoryPlan({super.key});

  @override
  State<SubscriptionCategoryPlan> createState() =>
      _SubscriptionCategoryPlanState();
}

class _SubscriptionCategoryPlanState extends State<SubscriptionCategoryPlan> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SubscriptionController>().fetchSubscriptionCatePlan();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      
      appBar: CustomAppbarDrawer(
        
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
                    final subscriptionCategoryModel = subscriptionController
                            .isLoading
                        ? SubscriptionCategoryModel()
                        : subscriptionController.subscriptionCateList[index];
                    return CustomShimmer(
                      isLoading: subscriptionController.isLoading,
                      child: SubscriptionCategoryContainer(
                          onPressed: () {
                            log("sub cate tap");
                            if (subscriptionController.isLoading) {
                              return;
                            }
                            subscriptionController
                                .updateSelectSubscriptionCategoryModel(
                                    subscriptionCategoryModel);
                            navigate(
                                type: PageTransitionType.rightToLeft,
                                context: context,
                                page: SubscriptionPlanScreen(
                                  subscriptionPlanName:
                                      subscriptionCategoryModel.name,
                                ));
                          },
                          subscriptionCategoryModel: subscriptionCategoryModel),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: subscriptionController.isLoading
                      ? 2
                      : subscriptionController.subscriptionCateList.length);
            })
          ],
        ),
      ),
    );
  }
}
