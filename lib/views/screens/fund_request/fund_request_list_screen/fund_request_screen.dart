import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lekra/controllers/fund_request_controller.dart';
import 'package:lekra/data/models/fund_reqests/fund_ruquest_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/drawer/drawer_screen.dart';
import 'package:lekra/views/screens/fund_request/form_fund_request/form_fund_request_screen.dart';
import 'package:lekra/views/screens/fund_request/fund_request_list_screen/component/fund_request_widget.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar_drawer.dart';
import 'package:page_transition/page_transition.dart';

class FundRequestScreen extends StatefulWidget {
  const FundRequestScreen({super.key});

  @override
  State<FundRequestScreen> createState() => _FundRequestScreenState();
}

class _FundRequestScreenState extends State<FundRequestScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      key: scaffoldKey,
      appBar: CustomAppbarDrawer(
        title: "Fund Requests",
        scaffoldKey: scaffoldKey,
      ),
      floatingActionButton: Container(
        child: GestureDetector(
          onTap: () => navigate(
              context: context,
              type: PageTransitionType.rightToLeft,
              page: const FormFundRequestScreen()),
          child: Container(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, right: 24, left: 16),
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
        child:
            GetBuilder<FundRequestController>(builder: (fundRequestController) {
          return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final fundRequest = fundRequestList[index];
                return FundRequestCard(
                    fundRequestModel: fundRequest, onTapView: () {});
              },
              separatorBuilder: (_, __) {
                return const SizedBox(
                  height: 12,
                );
              },
              itemCount: fundRequestList.length);
        }),
      ),
    );
  }
}
