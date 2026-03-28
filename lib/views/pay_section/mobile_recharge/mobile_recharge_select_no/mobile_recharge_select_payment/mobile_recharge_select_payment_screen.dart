import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/recharge_controller.dart';
import 'package:lekra/controllers/wallet_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_select_payment/widget/custom_button_pay_section.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_select_payment/widget/recharge_info_section.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_select_payment/widget/recharge_select_payment_section.dart';
import 'package:lekra/views/screens/dashboard/wallet/wallet_enter_pin_screen/wallet_enter_pin_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class MobileRechargeSelectPaymentScreen extends StatefulWidget {
  const MobileRechargeSelectPaymentScreen({super.key});

  @override
  State<MobileRechargeSelectPaymentScreen> createState() =>
      _MobileRechargeSelectPaymentScreenState();
}

class _MobileRechargeSelectPaymentScreenState
    extends State<MobileRechargeSelectPaymentScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<WalletController>().fetchWallet();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(title: "Payment"),
      bottomNavigationBar:
          GetBuilder<RechargeController>(builder: (rechargeController) {
        return CustomButtonForPaySection(
          title:
              "Pay Now ${rechargeController.selectRechargePlan?.planAmount ?? ""}",
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
        );
      }),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            RechargeInfoTopSection(),
            SizedBox(
              height: 32,
            ),
            RechargeSelectPaymentSection()
          ],
        ),
      ),
    );
  }
}
