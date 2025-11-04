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
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final homeController = Get.find<HomeController>();
    // threshold: 300 px before bottom
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300 &&
        !homeController.featuredState.isMoreLoading &&
        homeController.featuredState.canLoadMore) {
      // trigger load more
      homeController.fetchFeaturedProducts(loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerScreen(),
      appBar: HomeApp(
        scaffoldKey: scaffoldKey,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: AppConstants.screenPadding,
        child: const Column(
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
