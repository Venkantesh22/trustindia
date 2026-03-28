import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/recharge_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class CustomButtonForPaySection extends StatelessWidget {
  final String title;
  final Function() onTap;
  const CustomButtonForPaySection({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RechargeController>(builder: (rechargeController) {
      return SafeArea(
        child: Padding(
          padding: AppConstants.screenPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: LinearGradient(
                      colors: [blueLight, Color(0xFF0073DD)],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: Helper(context).textTheme.displaySmall?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: white,
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Powered by SecurePay Gateway",
                style: Helper(context).textTheme.displaySmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: greyText2,
                    ),
              )
            ],
          ),
        ),
      );
    });
  }
}
