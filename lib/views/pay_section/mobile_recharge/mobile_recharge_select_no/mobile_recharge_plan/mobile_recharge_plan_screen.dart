import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_plan/widget/recharge_plan_section.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_plan/widget/recharge_plan_top_section.dart';

class MobileRechargePlanScreen extends StatefulWidget {
  const MobileRechargePlanScreen({super.key});

  @override
  State<MobileRechargePlanScreen> createState() =>
      _MobileRechargePlanScreenState();
}

class _MobileRechargePlanScreenState extends State<MobileRechargePlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarBlueLight,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => pop(context),
          color: blueLight,
        ),
        title: Text(
          "Mobile Recharge plan",
          style: Helper(context).textTheme.headlineSmall?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: blueLight,
              ),
        ),
      ),
      body: Padding(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            RechargePlanTopSection(),
            SizedBox(height: 40),
            Expanded(child: MobileRechargePlanSection())
          ],
        ),
      ),
    );
  }
}
