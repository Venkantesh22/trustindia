import 'dart:developer';
import 'dart:io';
import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/models/user_model.dart';
import '../data/repositories/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool _acceptTerms = true;

  bool get isLoading => _isLoading;

  bool get acceptTerms => _acceptTerms;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  TextEditingController birthdayCodeController = TextEditingController();

  Future<ResponseModel> generateOtp({required String mobile}) async {
    log('----------- generateOtp Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "mobile": mobile,
      };

      Response response = await authRepo.generateOtp(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      if (response.body['status'] == true) {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "generateOtp updated");
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while generateOtp user");
      }
    } catch (e) {
      log('ERROR AT generateOtp(): $e');
      responseModel = ResponseModel(false, "Error while generateOtp user $e");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> generateEditOptSend({required String mobile}) async {
    log('----------- generateEditOptSend Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "mobile": mobile,
      };

      Response response = await authRepo.generateEditOptSend(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      if (response.body['status'] == true) {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "generateEditOptSend updated");
      } else {
        responseModel = ResponseModel(false,
            response.body['error'] ?? "Error while generateEditOptSend user");
      }
    } catch (e) {
      log('ERROR AT generateEditOptSend(): $e');
      responseModel =
          ResponseModel(false, "Error while generateEditOptSend user $e");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> generateResendOtp({required String mobile}) async {
    log('----------- generateResendOtp Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "mobile": mobile,
      };

      Response response = await authRepo.generateResendOtp(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      if (response.body['status'] == true) {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "generateResendOtp updated");
      } else {
        responseModel = ResponseModel(false,
            response.body['error'] ?? "Error while generateResendOtp user");
      }
    } catch (e) {
      log('ERROR AT generateResendOtp(): $e');
      responseModel =
          ResponseModel(false, "Error while generateResendOtp user $e");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> postVerifyOTP(
      {required String mobile, required String otp}) async {
    log('----------- postVerifyOTP Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "mobile": mobile,
        "otp": otp,
      };

      Response response = await authRepo.postVerifyOTP(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      if (response.body['status'] == true) {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "postVerifyOTP updated");
      } else {
        responseModel = ResponseModel(
            false, response.body['error'] ?? "Error while postVerifyOTP user");
      }
    } catch (e) {
      log('ERROR AT postVerifyOTP(): $e');
      responseModel = ResponseModel(false, "Error while postVerifyOTP user $e");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> registerUser() async {
    log('----------- registerUser Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "referral_code": referralCodeController.text.trim(),
        "mobile": numberController.text.trim(),
      };

      Response response = await authRepo.postUserRegister(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      if (response.body['status'] == true || response.body['success'] == true) {
        if (response.body['token'] != null) {
          authRepo.saveUserToken(response.body['token']);
        }

        responseModel = ResponseModel(
            true, response.body['message'] ?? "success registerUser ");
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        passwordController.clear();
        referralCodeController.clear();
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while registering user");
      }
    } catch (e) {
      log('ERROR AT registerUser(): $e');
      responseModel = ResponseModel(false, "Error while registering user $e");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  bool isPhoneNumberVerified = false;
  String? userPhoneNumber;
  Future<ResponseModel> userLogin({required bool isEmail}) async {
    log('----------- userLogin Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "email": isEmail ? emailController.text.trim() : "",
        "mobile": isEmail ? "" : emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      Response response = await authRepo.postUserLogin(data: FormData(data));

      log("Raw Response: ${response.body}");

      if (response.body['status'] == true) {
        if (response.body['token'] != null) {
          authRepo.saveUserToken(response.body['token']);
        }

        var userData = response.body['user'];

        if (userData != null) {
          isPhoneNumberVerified = (userData['is_verified'] == 1);

          userPhoneNumber = userData['mobile']?.toString();
        }

        log("isPhoneNumberVerified: $isPhoneNumberVerified");
        log("userPhoneNumber: $userPhoneNumber");

        responseModel =
            ResponseModel(true, response.body['message'] ?? "Login successful");
      }

      // ✅ 3. API returned failure (but HTTP was 200)
      else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while login user");
      }
    } catch (e) {
      log('ERROR AT userLogin(): $e');
      responseModel = ResponseModel(false, "Error while login user $e");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> registerVerifyOtp({required String otp}) async {
    log('----------- registerVerifyOtp Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "otp": otp,
        "mobile": numberController.text.trim(),
      };

      Response response =
          await authRepo.registerVerifyOtp(data: FormData(data));

      if (response.body['status'] == true || response.body['success'] == true) {
        if (response.body['token'] != null) {
          authRepo.saveUserToken(response.body['token']);
        }
        responseModel = ResponseModel(
            true, response.body['message'] ?? "registerVerifyOtp successful");
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while registerVerifyOtp");
      }
    } catch (e) {
      log('ERROR AT registerVerifyOtp(): $e');
      responseModel = ResponseModel(false, "Error while registerVerifyOtp  $e");
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
            ResponseModel(true, response.body['message'] ?? "logout ");
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        passwordController.clear();
        referralCodeController.clear();
      } else {
        responseModel = ResponseModel(
            false, response.body['error'] ?? "Error while logout");
      }
    } catch (e) {
      log("****** Error in logout() ******", name: "logout");
      responseModel = ResponseModel(false, "Error while  logout $e");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  UserModel? userModel;
  Future<ResponseModel> fetchUserProfile() async {
    log('-----------  fetchUserProfile() -------------');
    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Response response = await authRepo.fetchUserProfile();

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is Map) {
        responseModel =
            ResponseModel(true, response.body['message'] ?? "fetchUserProfile");
        userModel = UserModel.fromJson(response.body["data"]);
        lastNameController.text = userModel?.lastName ?? "";
        firstNameController.text = userModel?.firstName ?? "";
        emailController.text = userModel?.email ?? "";
        numberController.text = userModel?.mobile ?? "";
        birthdayCodeController.text = userModel?.dobFormat ?? "";
        setGender(value: userModel?.gender ?? "");
      } else {
        log("raw datat");
        responseModel = ResponseModel(
            false, response.body['error'] ?? "Something Went Wrong");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchUserProfile");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  File? profileImage;

  updateImages(File? image) {
    profileImage = image;
    update();
  }

  bool updateProfileLoading = false;

  Future<ResponseModel> updateProfile() async {
    log('----------- updateProfile Called ----------');
    updateProfileLoading = true;
    update();
    ResponseModel responseModel;

    try {
      Map<String, dynamic> data = {
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        'dob': birthdayCodeController.text.trim(),
        'gender': gender,
      };
      if (profileImage != null) {
        data.addAll({
          "image":
              MultipartFile(profileImage, filename: profileImage?.path ?? "")
        });
      }

      Response response =
          await authRepo.postUpdateProfile(data: FormData(data));

      if (response.statusCode == 200) {
        fetchUserProfile();

        responseModel = ResponseModel(
            true, response.body['message'] ?? "updateProfile updated");
      } else {
        responseModel = ResponseModel(
            false, response.body['error'] ?? "Error while updating profile");
      }
    } catch (e) {
      log("****** Error in updateProfile() ******", name: "updateProfile");
      responseModel = ResponseModel(false, "Error while updating profile $e");
    }

    updateProfileLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> updatePassword() async {
    log('----------- updatePassword Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "password": passwordController.text.trim(),
        "password_confirmation": confirmPasswordController.text.trim(),
        "mobile": numberController.text.trim(),
      };

      Response response = await authRepo.postUpdatePassword(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "updatePassword updated");
        numberController.clear();
        emailController.clear();
        passwordController.clear();
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while updatePassword ");
      }
    } catch (e) {
      log('ERROR AT updatePassword(): $e');
      responseModel = ResponseModel(false, "Error while updatePassword  $e");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  String? gender;

  List<String>? genderList = [
    "Male",
    "Female",
    "Other",
  ];

  void setGender({required String value}) {
    gender = value;
    update();
  }

  Future<ResponseModel> generateOtpFoUpdateMobileNo(
      {required String mobile}) async {
    log('----------- generateOtpFoUpdateMobileNo Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "mobile": mobile,
      };

      Response response = await authRepo.generateOtpFoUpdateMobileNo(
        data: FormData(data),
      );

      if (response.body['status'] == true) {
        responseModel = ResponseModel(true,
            response.body['message'] ?? "generateOtpFoUpdateMobileNo updated");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['error'] ??
                "Error while generateOtpFoUpdateMobileNo user");
      }
    } catch (e) {
      log('ERROR AT generateOtpFoUpdateMobileNo(): $e');
      responseModel = ResponseModel(
          false, "Error while generateOtpFoUpdateMobileNo user $e");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyOtpFoUpdateMobileNo({required String otp}) async {
    log('----------- verifyOtpFoUpdateMobileNo Called ----------');

    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "otp": otp,
        "mobile": numberController.text.trim(),
      };

      Response response =
          await authRepo.verifyOtpFoUpdateMobileNo(data: FormData(data));

      if (response.body['status'] == true || response.body['success'] == true) {
        responseModel = ResponseModel(true,
            response.body['message'] ?? "verifyOtpFoUpdateMobileNo successful");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Error while verifyOtpFoUpdateMobileNo");
      }
    } catch (e) {
      log('ERROR AT verifyOtpFoUpdateMobileNo(): $e');
      responseModel =
          ResponseModel(false, "Error while verifyOtpFoUpdateMobileNo  $e");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> checkReferral() async {
    try {
      print("----------- checkReferral ----------");

      // 1. USE THE REAL API AGAIN
      ReferrerDetails referrerDetails =
          await AndroidPlayInstallReferrer.installReferrer;
      String? referrerString = referrerDetails.installReferrer;

      if (referrerString != null && referrerString.isNotEmpty) {
        String finalCode = _extractCode(referrerString);
        print("Successfully found referral code: $finalCode");

        referralCodeController.text = finalCode;
        update();
      }
    } catch (e) {
      debugPrint("Failed to get referrer: $e");
    }
  }

//!-- for test a vs code
  // Future<void> checkReferral() async {
  //   try {
  //     print("----------- checkReferral ----------");

  //     // 🛑 1. COMMENT OUT THESE TWO LINES FOR NOW 🛑
  //     // ReferrerDetails referrerDetails = await AndroidPlayInstallReferrer.installReferrer;
  //     // String? referrerString = referrerDetails.installReferrer;

  //     // ✅ 2. ADD THIS FAKE STRING TO TEST YOUR LOGIC ✅
  //     String? referrerString =
  //         "https://play.google.com/store/apps/details?id=com.tpipay.trustindia&referrer=6QXXXDYWRH";

  //     if (referrerString.isNotEmpty) {
  //       String finalCode = _extractCode(referrerString);
  //       print("Successfully found referral code: $finalCode");

  //       referralCodeController.text = finalCode;
  //       update();
  //     }
  //   } catch (e) {
  //     debugPrint("Failed to get referrer: $e");
  //   }
  // }

// Helper method to extract the code from the Play Store referrer string
  String _extractCode(String parsedString) {
    // If the string contains 'referrer=', we extract just the code value
    if (parsedString.contains('referrer=')) {
      // We append the parsedString to your actual app URL using '&'
      // because the URL already has the '?id=' parameter.
      Uri uri = Uri.parse(
          'https://play.google.com/store/apps/details?id=com.tpipay.trustindia&$parsedString');

      // This will safely grab the '6QXXXDYWRH' part, ignoring everything else
      return uri.queryParameters['referrer'] ?? parsedString;
    }

    // If it doesn't contain 'referrer=', it might already be just the raw code
    return parsedString;
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
