import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/fund_request_controller.dart';
import 'package:lekra/data/models/fund_reqests/fund_ruquest_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/fund_request/form_fund_request/form_fund_request_screen.dart';
import 'package:lekra/views/screens/fund_request/fund_details_screen/fund_details_screen.dart';
import 'package:lekra/views/screens/fund_request/fund_request_list_screen/component/fund_request_widget.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar_drawer.dart';
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
      // canPop: false, // Prevent the default back action
      // // UPDATED: Using onPopInvokedWithResult
      // onPopInvokedWithResult: (didPop, result) async {
      //   // Show Exit Dialog
      //   final shouldExit = await showDialog<bool>(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: const Text('Exit App'),
      //       content: const Text('Do you want to exit the app?'),
      //       actions: [
      //         TextButton(
      //           onPressed: () => Navigator.of(context).pop(false),
      //           child: const Text('No'),
      //         ),
      //         TextButton(
      //           onPressed: () =>
      //               Navigator.of(context).pop(true), // Returns true
      //           child: const Text('Yes'),
      //         ),
      //       ],
      //     ),
      //   );

      //   if (shouldExit == true) {
      //     // Close the app
      //     if (context.mounted) {
      //       SystemNavigator.pop();
      //     }
      //   }
      // },
      child: Scaffold(
       
        appBar: CustomAppbarDrawer(
          title: "Fund Requests",
          
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
                    child: FundRequestCard(
                      fundRequestModel: fundRequest,
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
