import 'dart:developer';
import 'package:get/instance_manager.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/controllers/dashboard_controller.dart';
import 'package:lekra/controllers/home_controller.dart';
import 'package:lekra/data/repositories/product_repo.dart';
import 'package:lekra/data/repositories/home_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/auth_controller.dart';
import '../controllers/permission_controller.dart';
import '../data/api/api_client.dart';
import '../data/repositories/auth_repo.dart';
import '../data/repositories/basic_repo.dart';
import 'constants.dart';

class Init {
  initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut<SharedPreferences>(() => sharedPreferences);

    try {
      // ApiClient
      Get.lazyPut(() => ApiClient(
          appBaseUrl: AppConstants.baseUrl,
          sharedPreferences: sharedPreferences));

      Get.lazyPut(() => PermissionController());

      // Get Repo's...
      Get.lazyPut(
          () => AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
      Get.lazyPut(() => BasicRepo(apiClient: Get.find()));
      Get.lazyPut(() => HomeRepo(apiClient: Get.find()));
      Get.lazyPut(() => ProductRepo(apiClient: Get.find()));

      // Get Controller's...
      Get.lazyPut(() => DashBoardController());
      Get.lazyPut(() => AuthController(authRepo: Get.find()));
      Get.lazyPut(() => HomeController(homeRepo: Get.find()));
      Get.lazyPut(() => BasicController(basicRepo: Get.find()));
      Get.lazyPut(() => ProductController(categoryRepo: Get.find()));
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT initialize()");
    }
  }
}
