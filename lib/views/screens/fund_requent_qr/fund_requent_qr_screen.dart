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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<FundRequestController>().amountController.clear();
    });
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
