import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/home/category_model.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/home_repo.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo});
  bool isLoading = false;

  TextEditingController searchController = TextEditingController();

  List<CategoryModel> categoryList = [];

  Future<ResponseModel> fetchHomeCategory() async {
    log('----------- fetchHomeCategory Called() -------------');
    ResponseModel responseModel = ResponseModel(false, "Unknown error");
    isLoading = true;
    update();

    try {
      Response response = await homeRepo.getCategory();

      // ✅ Correct key is 'status'
      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data']['data'] is List) {
        categoryList = (response.body['data']['data'] as List)
            .map((item) => CategoryModel.fromJson(item))
            .toList();

        log("Category list : ${categoryList.length}");
        log("First category created_at: ${categoryList.first.createdAt}");
        responseModel = ResponseModel(true, "Success");
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

  List<ProductModel> featuredProductList = [];

  Future<ResponseModel> fetchFeaturedProducts() async {
    log('----------- fetchFeaturedProducts Called() -------------');
    ResponseModel responseModel = ResponseModel(false, "Unknown error");
    isLoading = true;
    update();

    try {
      Response response = await homeRepo.getFeaturedProducts();

      // ✅ Correct key is 'status'
      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data']['data'] is List) {
        featuredProductList = (response.body['data']['data'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();

        log("product list : ${featuredProductList.length}");
        responseModel =
            ResponseModel(true, " Success  Fetched fetchFeaturedProducts");
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchFeaturedProducts");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
