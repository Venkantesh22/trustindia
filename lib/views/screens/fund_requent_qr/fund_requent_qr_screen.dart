// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/fund_request_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/screens/fund_requent_qr/component/text_and_option_section.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class FundRequestQrScreen extends StatefulWidget {
  const FundRequestQrScreen({super.key});

  @override
  State<FundRequestQrScreen> createState() => _FundRequestQrScreenState();
}

class _FundRequestQrScreenState extends State<FundRequestQrScreen> {
  Timer? _statusTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final fundController = Get.find<FundRequestController>();
      fundController.setUpiQrModelNull();
      fundController.amountController.clear();
      _statusTimer =
          Timer.periodic(const Duration(milliseconds: 2000), (_) async {
        if ((fundController.upiQRModel?.orderId != null &&
            (fundController.upiQRModel?.orderId?.isNotEmpty ?? false))) {
          await fundController.uPIQRStatus().then(
            (value) {
              if (fundController.isPaymentDone) {
                _statusTimer?.cancel();
                pop(context);
                pop(context);
                showToast(
                    message:
                        "Congratulations! Your order has been placed successfully",
                    typeCheck: value.isSuccess);
              }
            },
          );
        }
      });
    });
  }

  void dispose() {
    _statusTimer?.cancel();
    // Get.find<FundRequestController>().setUpiQrModelNull();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar2(title: "Fund Request QR"),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            TextBoxAndOptionSection(),
          ],
        ),
      ),
    );
  }
}
