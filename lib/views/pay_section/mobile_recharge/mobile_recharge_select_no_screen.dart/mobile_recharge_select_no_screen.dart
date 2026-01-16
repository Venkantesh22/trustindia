import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/recharge_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';
import 'package:lekra/views/screens/widget/text_box/app_text_box.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: "Mobile Recharge",
        centerTitle: false,
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: AppConstants.screenPadding,
              child: CustomButton(
                onTap: () {},
                child: Text(
                  "Find Operator",
                  style: Helper(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder<RechargeController>(builder: (rechargeController) {
        return Padding(
          padding: AppConstants.screenPadding,
          child: Form(
              child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              AppTextFieldWithHeading(
                controller: rechargeController.mobileController,
                hindText: "91111 1111",
                heading: "Enter Mobile Recharge",
                prefixText: "+91",
                prefixStyle: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a Mobile";
                  }
                  if (value.length != 10) {
                    return "Enter a 10 Digit number";
                  }
                  return null;
                },
              )
            ],
          )),
        );
      }),
    );
  }
}
