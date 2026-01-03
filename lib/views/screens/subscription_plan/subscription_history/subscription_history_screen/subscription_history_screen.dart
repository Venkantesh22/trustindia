import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/subscription_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_history/subscription_history_details/subscription_history_details_screen.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_history/subscription_history_screen/components/subscription_history_widget.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class SubscriptionHistoryScreen extends StatefulWidget {
  const SubscriptionHistoryScreen({super.key});

  @override
  State<SubscriptionHistoryScreen> createState() =>
      _SubscriptionHistoryScreenState();
}

class _SubscriptionHistoryScreenState extends State<SubscriptionHistoryScreen> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SubscriptionController>().fetchSubscriptionHistory();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: "Subscription Hisory",
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    navigate(
                      context: context,
                      page: const SubscriptionHistoryDetailsScreen(),
                    );
                  },
                  child: const SubscriptionHistoryWidget());
            },
            separatorBuilder: (_, __) => const SizedBox(height: 18),
            itemCount: 10),
      ),
    );
  }
}
