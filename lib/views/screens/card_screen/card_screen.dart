import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/screens/card_screen/components/cardItemSection.dart';
import 'package:lekra/views/screens/card_screen/components/checkout_button.dart';
import 'package:lekra/views/screens/card_screen/components/order_summary.dart';
import 'package:lekra/views/screens/widget/custom_appbar2.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar2(
        title: "Cart",
      ),
      body: Padding(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardItemListSection(),
            SizedBox(
              height: 12,
            ),
            OrderSummarySection(),
            CheckoutButtonSection(),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
