import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class MobileRechargeSelectNoScreen extends StatefulWidget {
  const MobileRechargeSelectNoScreen({super.key});

  @override
  State<MobileRechargeSelectNoScreen> createState() =>
      _MobileRechargeSelectNoScreenState();
}

class _MobileRechargeSelectNoScreenState
    extends State<MobileRechargeSelectNoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        title: "Mobile Recharge",
        centerTitle: false,
      ),
      body: Padding(
        padding: AppConstants.screenPadding,
        child: Form(
            child: Column(
          children: [
            // AppTextFieldWithHeading(controller:  , hindText: hindText)
          ],
        )),
      ),
    );
  }
}
