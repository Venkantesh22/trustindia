import 'dart:developer';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get.dart';
import 'package:lekra/services/extensions.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/constants.dart';
import '../api/api_client.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  AuthRepo({required this.sharedPreferences, required this.apiClient});

  // Future<Response> generateOtp({required String phone}) async => await apiClient.postData(AppConstants.generateOtp, {"mobile": phone});

  // Future<Response> verifyOtp({required String phone, required String otp}) async => await apiClient.postData(
  // AppConstants.loginUri, {
  // "mobile": phone,
  // 'otp': otp,
  // 'device_id': await getDeviceId(),
  // },
  // );

  // Future<Response> login({required String phone}) async => await apiClient.postData(
  //       AppConstants.sendOtp,
  //       {
  //         "phone": phone,
  //         "app_signature": await Get.find<OtpAutofillController>().getAppSignature(),
  //       },
  //     );

  // Future<Response> verifyOtp({required String phone, required String otp}) async => await apiClient.postData(
  //       AppConstants.verifyOtp,
  //       {
  //         "phone": phone,
  //         "otp": otp,
  //       },
  //     );

  Future<Response> postUserRegister({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.userRegisterUri,
        data,
      );

  Future<Response> postUserLogin({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.loginUri,
        data,
      );
  Future<Response> postLogout() async =>
      await apiClient.postData(AppConstants.logoutUri, "");

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  // Future<void> setUserToken(String token) async {
  //   apiClient.updateHeader(token);
  //   await sharedPreferences.setString(AppConstants.token, token);
  // }
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  String getUserId() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.userId);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }

  Future<String> getDeviceId() async {
    int count = 0;

    while (OneSignal.User.pushSubscription.id.isNotValid && count < 0) {
      await Future.delayed(const Duration(seconds: 1));
      count++;

      log(count.toString(), name: 'DeviceId Wait Count');
      log('${OneSignal.User.pushSubscription.id}', name: "12345678");
      log('${OneSignal.User.pushSubscription.token}', name: "12345678");
    }

    if (OneSignal.User.pushSubscription.id.isValid) {
      return OneSignal.User.pushSubscription.id!;
    } else {
      return '12345678';
    }
  }
}
