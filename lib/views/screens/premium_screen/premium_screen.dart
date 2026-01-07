import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/generated/assets.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/premium_screen/components/premium_bottom_section.dart';
import 'package:lekra/views/screens/premium_screen/components/premium_medium_section.dart';
import 'package:lekra/views/screens/premium_screen/components/premium_top_section.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
