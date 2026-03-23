import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/success_recharge_screen/widget/success_median_section.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/success_recharge_screen/widget/success_top_section.dart';

class SuccessRechargeScreen extends StatelessWidget {
  const SuccessRechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            SizedBox(height: 60),
            Success_top_section(),
            SizedBox(height: 19),
            Success_median_section(),
            SizedBox(height: 19),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    radius: 100,
                    color: secondaryColor,
                    borderColor: secondaryColor,
                    onTap: () {},
                    child: Text(
                      "CLOSE",
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                    ),
                  ),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: CustomButton(
                    radius: 100,
                    color: secondaryColor,
                    borderColor: secondaryColor,
                    onTap: () {},
                    child: Text(
                      "VIEW DETAILS",
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
