import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/screens/premium_screen/components/premium_bottom_section.dart';
import 'package:lekra/views/screens/premium_screen/components/premium_medium_section.dart';
import 'package:lekra/views/screens/premium_screen/components/premium_top_section.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              PremiumTopSection(),
              PremiumMediumSection(),
              PremiumBottomSection(),
            ],
          ),
        ),
      ),
    );
  }
}
