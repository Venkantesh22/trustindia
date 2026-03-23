import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/recharge_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_select_option_wallet_dynamic/widget/custom_button_for_recharge.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/success_recharge_screen/success_recharge_screen.dart';
import 'package:lekra/views/screens/dashboard/wallet/wallet_enter_pin_screen/wallet_enter_pin_screen.dart';

class MobileRechargeSelectOptionsWalletDynamicScreen extends StatelessWidget {
  const MobileRechargeSelectOptionsWalletDynamicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => pop(context),
          icon: const Icon(
            Icons.close,
            color: black,
          ),
        ),
      ),
      body: GetBuilder<RechargeController>(builder: (rechargeController) {
        return Padding(
          padding: AppConstants.screenPadding,
          child: Center(
            child: Column(
              children: [
                Spacer(),
                CustomImage(
                  path: rechargeController.selectNetworkOperate?.logo ?? "",
                  height: 80,
                  width: 80,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Paying ${rechargeController.selectNetworkOperate?.networkName} Prepaid",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    "+91 ${rechargeController.mobileNoController.text}",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: greyVeryDark,
                        ),
                  ),
                ),
                Text(
                  "₹ ${rechargeController.rechargeAmountController.text}",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Spacer(),
                CustomButtonForRecharge(
                  onTap: () {
                    navigate(
                      context: context,
                      page: WalletEnterPinScreen(
                        isMobileRecharge: true,
                      ),
                    );
                  },
                  title: "Pay with Wallet",
                  icon: Icons.wallet,
                ),
                SizedBox(
                  height: 26,
                ),
                CustomButtonForRecharge(
                  onTap: () {
                    navigate(
                      context: context,
                      page: SuccessRechargeScreen(),
                    );
                  },
                  title: "Dynamic QR",
                  icon: Icons.qr_code_2,
                ),
                Spacer(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
