import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/wallet_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_select_payment/widget/bottom_button.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_select_payment/widget/recharge_info_section.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_select_payment/widget/recharge_select_payment_section.dart';
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
      bottomNavigationBar: BottomButton(),
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
