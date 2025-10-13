import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/home_repo.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo});
  bool isLoading = false;

  TextEditingController searchController = TextEditingController();

// List<BannerModel> sliders = [];

  Future<ResponseModel> fetchHomeCategory() async {
    log('----------- fetchHomeCategory Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await homeRepo.getCategory();

      // ✅ Correct key is 'status'
      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is List) {
        // ✅ Parse banners
        // sliders = (response.body['data'] as List)
        //     .map((item) => BannerModel.fromJson(item))
        //     .toList();

        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "fetchHomeCategory fetched",
        );
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchHomeCategory");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
