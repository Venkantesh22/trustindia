import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/controllers/home_controller.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/screens/dashboard/home_screen/components/explore_category_section.dart';
import 'package:lekra/views/screens/dashboard/home_screen/components/featured_section.dart';
import 'package:lekra/views/screens/dashboard/home_screen/components/home_appbar.dart';
import 'package:lekra/views/screens/dashboard/home_screen/components/home_banner.dart';
import 'package:lekra/views/screens/dashboard/home_screen/components/hot_deals_today.dart';
import 'package:lekra/views/screens/drawer/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BasicController>().fetchHomeBanner();
      Get.find<HomeController>().fetchHomeCategory();
      Get.find<HomeController>().fetchFeaturedProducts();
      Get.find<HomeController>().fetchHotDealsTodayProducts();
      Get.find<ProductController>().fetchCard();
      Get.find<AuthController>().fetchUserProfile();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
      drawer: const DrawerScreen(),
      appBar:  HomeApp(scaffoldKey: scaffoldKey,),
      body: const SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            HomeBanner(),
            ExploreCategorySection(),
            HotDealTodaySection(),
            FeaturedSection(),
          ],
        ),
      ),
    );
  }
}
