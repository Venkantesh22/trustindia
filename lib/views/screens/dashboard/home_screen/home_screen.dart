import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/dashboard/home_screen/components/explore_category_section.dart';
import 'package:lekra/views/screens/dashboard/home_screen/components/featured_section.dart';
import 'package:lekra/views/screens/dashboard/home_screen/components/home_appbar.dart';
import 'package:lekra/views/screens/dashboard/home_screen/components/home_banner.dart';
import 'package:lekra/views/screens/dashboard/home_screen/components/hot_deals_today.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeApp(),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            const HomeBanner(),
            ExploreCategorySection(),
            HotDealTodaySection(),
            FeaturedSection(),
          ],
        ),
      ),
    );
  }
}
