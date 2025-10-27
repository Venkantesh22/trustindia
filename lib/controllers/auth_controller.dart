import 'dart:developer';
import 'dart:io';

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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

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

      if (response.body['status'] == true || response.body['success'] == true) {
        if (response.body['token'] != null) {
          authRepo.saveUserToken(response.body['token']);
        }

        responseModel =
            ResponseModel(true, response.body['message'] ?? "Profile updated");
        nameController.clear();
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

      Response response = await authRepo.postUserLogin(data: FormData(data));

      log("Raw Response: ${response.body}");

      if (response.body['status'] == true || response.body['success'] == true) {
        // ✅ 3. Save token if exists
        if (response.body['token'] != null) {
          authRepo.saveUserToken(response.body['token']);
        }

        responseModel =
            ResponseModel(true, response.body['message'] ?? "Login successful");
        emailController.clear();
        passwordController.clear();
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
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while logout");
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
        nameController.text = userModel?.name ?? "";
        emailController.text = userModel?.email ?? "";
        numberController.text = userModel?.mobile ?? "";
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Something Went Wrong");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchUserProfile");
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  TextEditingController numberController = TextEditingController();

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
        "name": nameController.text,
        "mobile": numberController.text,
      };
      if (profileImage != null) {
        data.addAll({
          "image":
              MultipartFile(profileImage, filename: profileImage?.path ?? "")
        });
      }
      log(data.toString());
      Response response =
          await authRepo.postUpdateProfile(data: FormData(data));

      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(response.body['data']);
        responseModel = ResponseModel(
            true, response.body['message'] ?? "updateProfile updated");
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while updating profile");
      }
    } catch (e) {
      log("****** Error in updateProfile() ******", name: "updateProfile");
      responseModel = ResponseModel(false, "Error while updating profile $e");
    }

    updateProfileLoading = false;
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
