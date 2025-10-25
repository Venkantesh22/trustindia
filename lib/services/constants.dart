import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lekra/main.dart';
import 'package:lekra/services/route_helper.dart';
import 'package:lekra/services/theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class PriceConverter {
  static convert(price) {
    return '₹ ${double.parse('$price').toStringAsFixed(2)}';
  }

  static convertRound(price) {
    return '₹ ${double.parse('$price').toInt()}';
  }

  static convertToNumberFormat(num price) {
    final format = NumberFormat("#,##,##,##0.00", "en_IN");
    return '₹ ${format.format(price)}';
  }
}

class Helper {
  final BuildContext context;
  Helper(this.context);

  Size get size => MediaQuery.sizeOf(context);
  TextTheme get textTheme => Theme.of(context).textTheme;
}

String capitalize(String? s) {
  if (s == null || s.isEmpty) return "";
  return s[0].toUpperCase() + s.substring(1);
}

void navigate({
  PageTransitionType type = PageTransitionType.fade,
  required BuildContext context,
  required Widget page,
  bool isReplace = false,
  bool isRemoveUntil = false,
  Duration duration = const Duration(milliseconds: 300),
}) {
  if (isReplace) {
    Navigator.of(context).pushReplacement(
      getCustomRoute(
        child: page,
        type: type,
        duration: duration,
      ),
    );
  } else if (isRemoveUntil) {
    Navigator.of(context).pushAndRemoveUntil(
      getCustomRoute(
        child: page,
        type: type,
        duration: duration,
      ),
      (route) => false,
    );
  } else {
    Navigator.of(context).push(
      getCustomRoute(
        child: page,
        type: type,
        duration: duration,
      ),
    );
  }
}

void pop(BuildContext context, {dynamic data}) {
  Navigator.pop(context, data);
}

enum ToastType {
  info(ToastificationType.info),
  warning(ToastificationType.warning),
  error(ToastificationType.error),
  success(ToastificationType.success);

  const ToastType(this.value);
  final ToastificationType value;
}

void showToast(
    {ToastType? toastType,
    required String message,
    String? description,
    ToastificationStyle? toastificationStyle,
    bool? typeCheck}) {
  toastification.show(
    alignment: Alignment.topLeft,
    type: toastType?.value ??
        ((typeCheck ?? false)
            ? ToastificationType.success
            : ToastificationType.error),
    title: Text(
      message,
      style:
          Helper(navigatorKey.currentContext!).textTheme.bodyMedium!.copyWith(
                color: black,
                fontSize: 14,
              ),
    ),
    description: description != null
        ? Text(description,
            style: Helper(navigatorKey.currentContext!)
                .textTheme
                .bodySmall!
                .copyWith(
                  color: black,
                ))
        : null,
    style: toastificationStyle ?? ToastificationStyle.minimal,
    icon: toastType == ToastType.success
        ? const Icon(Icons.check_circle_outline)
        : toastType == ToastType.error
            ? const Icon(Icons.error_outline)
            : toastType == ToastType.warning
                ? const Icon(Icons.warning_amber)
                : const Icon(Icons.info_outline),
    autoCloseDuration: const Duration(seconds: 2),
  );
}

String getStringFromList(List<dynamic>? data) {
  String str = data.toString();
  return data.toString().substring(1, str.length - 1);
}

class AppConstants {
  String get getBaseUrl => baseUrl;
  set setBaseUrl(String url) => baseUrl = url;
//http://ecom.tpipaygroup.com/api/register-user
  //TODO: Change Base Url
  static String baseUrl = 'http://ecom.tpipaygroup.com/';
  // static String baseUrl = 'http://192.168.1.5:9000/'; ///USE FOR LOCAL
  //TODO: Change Base Url
  static String appName = 'Trust India';

  static const String agoraAppId = 'c87b710048c049f59570bd1895b7e561';

  // Auth
  static const String userRegisterUri = 'api/register-user';
  static const String loginUri = 'api/login-post';
  static const String logoutUri = 'api/logout';
  static const String profileUri = 'api/profile';

  // Address
  static const String getAddress = 'api/get-address';
  static const String postAddAddress = 'api/add-address';
  static const String postDeleteAddress = 'api/delete-address';
  static const String getAddressById = 'api/order-address/2';


  // Basic
  static const String bannerUri = 'api/banners';

  //Home
  static const String categoryList = "api/category";
  static const String getFeaturedProducts = "api/products";
  static const String getHotDealsTodayProducts = "api/today-hot-deals";

  //wallet
  static const String getWalletTransaction = "api/wallet/transactions";

  // Check out
  static const String postCheckOut = "api/checkout";
  static const String postPayOrderWalled = "api/pay-order";
  static const String getOrder = "api/orders";



  //Product screen
  static const String getCategoryDetails = "api/category-details";
  static const String getProductDetails = "api/products-details";
  static const String postAddToCard = "api/add-carts";
  static const String postRemoveToCard =
      "api/cart/decrease"; // Product Quection is decrease by 1
  static const String getCard = "api/carts";


  // Referral Structure
    static const String getReferral = "api/referrals";

  // rewards Structure
    static const String fetchScratchCard = "api/rewards";






  static const double horizontalPadding = 16;
  static const double verticalPadding = 20;
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
      horizontal: AppConstants.horizontalPadding,
      vertical: AppConstants.verticalPadding);

  // Shared Key
  static const String token = 'user_app_token';
  static const String userId = 'user_app_id';
  static const String razorpayKey = 'razorpay_key';
  static const String recentOrders = 'recent_orders';
  static const String isUser = 'is_user';
}
