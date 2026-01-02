import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_history/subscription_history_details/components/subscription_details_botton_section.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_history/subscription_history_details/components/subscription_details_median_section.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_history/subscription_history_details/components/subscription_details_top_section.dart';

class SubscriptionHistoryDetailsScreen extends StatefulWidget {
  const SubscriptionHistoryDetailsScreen({super.key});

  @override
  State<SubscriptionHistoryDetailsScreen> createState() =>
      _SubscriptionHistoryDetailsScreenState();
}

class _SubscriptionHistoryDetailsScreenState
    extends State<SubscriptionHistoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "INVOICE",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: black,
              ),
        ),
        leading: IconButton(
            tooltip: "Back",
            onPressed: () {
              pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: black,
            )),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            const SubscriptionDetailsTopSection(),
            const SizedBox(height: 33),
            SubscriptionDetailsMedianSection(),
            const SizedBox(height: 33),
            SubscriptionDetailsBottonSection(),
          ],
        ),
      ),
    );
  }
}
