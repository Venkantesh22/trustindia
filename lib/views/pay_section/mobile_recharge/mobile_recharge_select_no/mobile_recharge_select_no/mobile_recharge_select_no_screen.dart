import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/recharge_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_plan/mobile_recharge_plan_screen.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_select_no/widget/mobile_recharge_no_top_section.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_select_no/widget/moble_recharge_no_mid_section.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class MobileRechargeSelectNoScreen extends StatefulWidget {
  const MobileRechargeSelectNoScreen({super.key});

  @override
  State<MobileRechargeSelectNoScreen> createState() =>
      _MobileRechargeSelectNoScreenState();
}

class _MobileRechargeSelectNoScreenState
    extends State<MobileRechargeSelectNoScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final rechargeController = Get.find<RechargeController>();
      rechargeController.mobileNoController.clear();
      rechargeController.selectNetworkOperate = null;
      rechargeController.selectRechargeStateAreaModel = null;
      rechargeController.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: "Mobile Recharge",
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: AppConstants.screenPadding,
              child:
                  GetBuilder<RechargeController>(builder: (rechargeController) {
                return CustomButton(
                  isLoading: rechargeController.isLoading,
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      rechargeController
                          .fetchMobileRechargePlan()
                          .then((value) {});
                      navigate(
                        context: context,
                        page: MobileRechargePlanScreen(),
                      );
                    }
                  },
                  child: Text(
                    "See Plan",
                    style: Helper(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: white,
                        ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      body: GetBuilder<RechargeController>(builder: (rechargeController) {
        return SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MobileRechargeNoTopSection(),
                MobileRechargeNoMidSection()
              ],
            ),
          ),
        );
      }),
    );
  }
}
