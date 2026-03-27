import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/recharge_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/dashboard/wallet/wallet_enter_pin_screen/wallet_enter_pin_screen.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
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
                onTap: () {
                  if (rechargeController.selectedPaymentIndex == 0) {
                    navigate(
                      context: context,
                      page: WalletEnterPinScreen(
                        isMobileRecharge: true,
                      ),
                    );
                  }
                },
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
                      "Pay Now ${rechargeController.selectRechargePlan?.planAmount ?? ""}",
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
