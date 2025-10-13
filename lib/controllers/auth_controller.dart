import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/models/response/user_model.dart';
import '../data/repositories/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool _acceptTerms = true;

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  bool get isLoading => _isLoading;

  bool get acceptTerms => _acceptTerms;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

  // Future<ResponseModel> generatedOtp({required String phone}) async {
  //   log('----------- generatedOtp Called ----------');
  //
  //   ResponseModel responseModel;
  //   _isLoading = true;
  //   update();
  //
  //   try {
  //     Response response = await authRepo.generateOtp(phone: phone);
  //     if ((response.data as Map).containsKey('errors')) {
  //       Fluttertoast.showToast(msg: '${response.data['message']}', toastLength: Toast.LENGTH_LONG);
  //       responseModel = ResponseModel(false, response.statusMessage ?? '', response.data['errors']);
  //     } else if (response.statusCode == 200 && response.data['success']) {
  //       responseModel = ResponseModel(true, response.statusMessage ?? '', response.data['message']);
  //       Fluttertoast.showToast(msg: '${response.data['message']}', toastLength: Toast.LENGTH_LONG);
  //     } else {
  //       responseModel = ResponseModel(false, response.statusMessage ?? '', response.data['errors']);
  //     }
  //   } catch (e) {
  //     responseModel = ResponseModel(false, "CATCH");
  //     log('++++++++++++++ ${e.toString()} +++++++++++++++++++++++++', name: "ERROR AT generatedOtp()");
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }
  //
  // Future<ResponseModel> verifyOtp({required String phone, required String otp}) async {
  //   log('----------- verifyOtp Called ----------');
  //
  //   ResponseModel responseModel;
  //   _isLoading = true;
  //   update();
  //
  //   try {
  //     Response response = await authRepo.verifyOtp(phone: phone, otp: otp);
  //     if ((response.data as Map).containsKey('errors')) {
  //       Fluttertoast.showToast(msg: '${response.data['message']}', toastLength: Toast.LENGTH_LONG);
  //       responseModel = ResponseModel(false, response.statusMessage ?? '', response.data['errors']);
  //     } else if (response.statusCode == 200 && response.data['success']) {
  //       if (response.data['otp_verified']) {
  //         responseModel = ResponseModel(true, response.statusMessage ?? '');
  //         setUserToken(id: response.data['token']);
  //         Fluttertoast.showToast(msg: 'Otp Verified', toastLength: Toast.LENGTH_LONG);
  //       } else {
  //         responseModel = ResponseModel(true, response.statusMessage ?? '');
  //         Fluttertoast.showToast(msg: 'Incorrect Otp', toastLength: Toast.LENGTH_LONG);
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: 'Something Went Wrong', toastLength: Toast.LENGTH_LONG);
  //       responseModel = ResponseModel(false, response.statusMessage ?? '', response.data['errors']);
  //     }
  //   } catch (e) {
  //     responseModel = ResponseModel(false, "CATCH");
  //     log('++++++++++++++ ${e.toString()} +++++++++++++++++++++++++', name: "ERROR AT verifyOtp()");
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }
  //
  // Future<ResponseModel> logoutUser() async {
  //   log('----------------- logoutUser Called ----------------');
  //
  //   ResponseModel responseModel;
  //
  //   try {
  //     Response response = await authRepo.logoutUser();
  //
  //     if (response.statusCode == 200) {
  //       if (response.data['success'] == true && response.data['message'] != null) {
  //         clearSharedData();
  //         Navigator.pushAndRemoveUntil(navigatorKey.currentContext!, getCustomRoute(child: const LoginScreen()), (route) => false);
  //         responseModel = ResponseModel(true, response.statusMessage ?? '');
  //         Fluttertoast.showToast(msg: response.data['message']);
  //       } else {
  //         responseModel = ResponseModel(false, response.statusMessage ?? '');
  //       }
  //     } else {
  //       responseModel = ResponseModel(false, response.statusMessage ?? '');
  //     }
  //   } catch (e) {
  //     responseModel = ResponseModel(false, "CATCH");
  //     log('++++++++++++++ ${e.toString()} +++++++++++++++++++++++++', name: "ERROR AT logoutUser()");
  //   }
  //
  //   return responseModel;
  // }
  //
  // Future<ResponseModel> getUserProfileData() async {
  //   log('----------- getUserProfileData Called ----------');
  //
  //   ResponseModel responseModel;
  //   _isLoading = true;
  //   update();
  //
  //   try {
  //     Response response = await authRepo.getUser();
  //     if (response.statusCode == 200) {
  //       log(response.data.toString(), name: 'ResponseDATA');
  //       if (response.data['success'] == true && response.data['data'] != null) {
  //         _userModel = UserModel.fromJson(response.data['data']);
  //         log(response.statusMessage!, name: "UserModel");
  //         authRepo.saveUserId('${_userModel!.id}');
  //         setGloabalViewStatus(status: _userModel?.isManager ?? false);
  //         responseModel = ResponseModel(true, '${response.statusMessage}');
  //       } else {
  //         responseModel = ResponseModel(false, response.statusMessage ?? '');
  //       }
  //     } else {
  //       ApiChecker.checkApi(response);
  //       responseModel = ResponseModel(false, "${response.statusMessage}");
  //     }
  //   } catch (e) {
  //     log('---- ${e.toString()} ----', name: "ERROR AT getUserProfileData()");
  //     responseModel = ResponseModel(false, "$e");
  //   }
  //
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  Future<ResponseModel> registerUser() async {
    log('----------- registerUser Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "referral_code": referralCodeController.text.trim(),
      };

      Response response = await authRepo.postUserRegister(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      // Accept 200 or 201 as success
      if (response.statusCode != 200 && response.statusCode != 201) {
        responseModel = ResponseModel(
          false,
          response.body['message']?.toString() ?? 'Server error',
          response.body['error'] ?? 'Unknown error',
        );
        Fluttertoast.showToast(
            msg: response.body['message']?.toString() ?? 'Server error');
      }
      // Check for status/success key
      else if (response.body['status'] == true ||
          response.body['success'] == true) {
        if (response.body['token'] != null) {
          authRepo.saveUserToken(response.body['token']);
        }
        responseModel = ResponseModel(
          true,
          response.body['message']?.toString() ?? '',
        );
        Fluttertoast.showToast(msg: response.body['message']?.toString() ?? '');
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message']?.toString() ?? '',
          response.body['error'] ?? 'Unknown error',
        );
        Fluttertoast.showToast(msg: response.body['message']?.toString() ?? '');
      }
    } catch (e) {
      log('ERROR AT registerUser(): $e');
      responseModel = ResponseModel(false, "CATCH");
      Fluttertoast.showToast(msg: "Registration failed. Please try again.");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> userLogin() async {
    log('----------- userLogin Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      // ✅ Send as JSON Map (recommended)
      Response response = await authRepo.postUserLogin(data: FormData(data));

      log("Raw Response: ${response.body}");

      // ✅ 1. Check HTTP status code (200 or 201 = success)
      if (response.statusCode != 200 && response.statusCode != 201) {
        responseModel = ResponseModel(
          false,
          response.body['message']?.toString() ?? 'Server error',
          response.body['error']?.toString() ?? 'Unknown error',
        );
        Fluttertoast.showToast(
          msg: response.body['message']?.toString() ?? 'Server error',
        );
      }

      // ✅ 2. API success check (status or success == true)
      else if (response.body['status'] == true ||
          response.body['success'] == true) {
        // ✅ 3. Save token if exists
        if (response.body['token'] != null) {
          authRepo.saveUserToken(response.body['token']);
        }

        responseModel = ResponseModel(
          true,
          response.body['message']?.toString() ?? 'Login successful',
        );

        Fluttertoast.showToast(
          msg: response.body['message']?.toString() ?? 'Login successful',
        );
      }

      // ✅ 3. API returned failure (but HTTP was 200)
      else {
        responseModel = ResponseModel(
          false,
          response.body['message']?.toString() ?? 'Login failed',
          response.body['error']?.toString() ?? 'Unknown error',
        );

        Fluttertoast.showToast(
          msg: response.body['message']?.toString() ?? 'Login failed',
        );
      }
    } catch (e) {
      log('ERROR AT userLogin(): $e');
      responseModel = ResponseModel(false, "CATCH");
      Fluttertoast.showToast(msg: "Login failed. Please try again.");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> logout() async {
    log('----------- logout Called ----------');

    _isLoading = true;
    update();
    ResponseModel responseModel;
    try {
      Response response = await authRepo.postLogout();

      if (response.statusCode == 200) {
        responseModel =
            ResponseModel(true, response.body['message'] ?? "Profile updated");
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while updating profile");
      }
    } catch (e) {
      log("****** Error in updateProfile() ******", name: "updateProfile");
      responseModel = ResponseModel(false, "Error while updating profile $e");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }
}
