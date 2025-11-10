import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/fund_request_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/fund_request/fund_details_screen/components/fund_bank_details_container.dart';
import 'package:lekra/views/screens/fund_request/fund_details_screen/components/fund_details_container.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class FundDetailsScreen extends StatefulWidget {
  const FundDetailsScreen({super.key});

  @override
  State<FundDetailsScreen> createState() => _FundDetailsScreenState();
}

class _FundDetailsScreenState extends State<FundDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<FundRequestController>().fetchFundDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Fund Details"),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child:
            GetBuilder<FundRequestController>(builder: (fundRequestController) {
          return Column(
            children: [
              CustomShimmer(
                isLoading: fundRequestController.isLoading,
                child: FundDetailsContainer(
                  fundRequestsModel:
                      fundRequestController.selectFundRequestModel,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              CustomShimmer(
                isLoading: fundRequestController.isLoading,
                child: FundBankDetailsContainer(
                  fundRequestsModel:
                      fundRequestController.selectFundRequestModel,
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
