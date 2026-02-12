import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/fund_request_controller.dart';
import 'package:lekra/data/models/fund_reqests/fund_ruquest_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/fund_requent_qr/fund_requent_qr_screen.dart';
import 'package:lekra/views/screens/fund_request/form_fund_request/form_fund_request_screen.dart';
import 'package:lekra/views/screens/fund_request/fund_details_screen/fund_details_screen.dart';
import 'package:lekra/views/screens/fund_request/fund_request_list_screen/component/fund_request_widget.dart';
import 'package:page_transition/page_transition.dart';

class FundRequestScreen extends StatefulWidget {
  const FundRequestScreen({super.key});

  @override
  State<FundRequestScreen> createState() => _FundRequestScreenState();
}

class _FundRequestScreenState extends State<FundRequestScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<FundRequestController>().fetchFundStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                navigate(context: context, page: const FundRequestQrScreen());
              },
              icon: const Icon(
                Icons.qr_code_scanner_sharp,
                color: black,
              ),
            ),
            const SizedBox(width: 10)
          ],
          leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: black,
              )),
          centerTitle: true,
          title: Text(
            "Fund Requests",
            style: Helper(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: Container(
          child: GestureDetector(
            onTap: () => navigate(
                context: context,
                type: PageTransitionType.rightToLeft,
                page: const FormFundRequestScreen()),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 16, right: 24, left: 16),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.add,
                    color: white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Add Request",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: GetBuilder<FundRequestController>(
              builder: (fundRequestController) {
            return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final fundRequest = fundRequestController.isLoading
                      ? FundRequestsModel()
                      : fundRequestController.fundRequestsList[index];
                  return GestureDetector(
                    onTap: () {
                      if (fundRequestController.isLoading) {
                        return;
                      }
                      fundRequestController
                          .setSelectFundRequestsModel(fundRequest);
                      navigate(
                          context: context,
                          type: PageTransitionType.rightToLeft,
                          page: const FundDetailsScreen());
                    },
                    child: CustomShimmer(
                      isLoading: fundRequestController.isLoading,
                      child: FundRequestCard(
                        fundRequestModel: fundRequest,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                itemCount: fundRequestController.isLoading
                    ? 4
                    : fundRequestController.fundRequestsList.length);
          }),
        ),
      ),
    );
  }
}
