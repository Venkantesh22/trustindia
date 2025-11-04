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
  
  // Pagination state
  int featuredPage = 1;
  int featuredLastPage = 1;
  final int pageSize = 10; // adjust to taste (10-20 is common)
  bool isFeaturedInitialLoading = false;
  bool isFeaturedMoreLoading = false;

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

      if (response.statusCode == 200 && response.body['status'] == true) {
        final productsJson = response.body['data']?['data'] ?? [];

        if (productsJson is List) {
          featuredProductList = (response.body['data']?['data'] as List)
              .map((item) => ProductModel.fromJson(item))
              .toList();
          // featuredProductList =
          //     productsJson.map((item) => ProductModel.fromJson(item)).toList();

          log("product list : ${featuredProductList.length}");
          responseModel =
              ResponseModel(true, "Successfully fetched featured products");
        } else {
          log("product list else : ${featuredProductList.length}");

          featuredProductList = [];
          responseModel = ResponseModel(false, "No products found");
        }
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Error: $e");
      log("****** Error ****** $e", name: "fetchFeaturedProducts");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  List<ProductModel> hotDealsTodayProductList = [];

  Future<ResponseModel> fetchHotDealsTodayProducts() async {
    log('----------- fetchHotDealsTodayProducts Called() -------------');
    ResponseModel responseModel = ResponseModel(false, "Unknown error");
    isLoading = true;
    update();

    try {
      Response response = await homeRepo.fetchHotDealsTodayProducts();

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data']['data'] is List) {
        hotDealsTodayProductList = (response.body['data']['data'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();

        print("hot deals list : ${hotDealsTodayProductList.length}");
      } else {
        print("No hot deals found or invalid response structure");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchHotDealsTodayProducts");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  List<ProductModel> searchProductList = [];

  Future<ResponseModel> fetchSearchProduct({required String query}) async {
    log('----------- fetchSearchProduct Called() -------------');
    ResponseModel responseModel = ResponseModel(false, "Unknown error");
    isLoading = true;
    update();

    try {
      Response response = await homeRepo.fetchSearchProduct(query: query);

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['products'] is List) {
        searchProductList = (response.body['products'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();

        log("searchProductList list : ${searchProductList.length}");
        responseModel = ResponseModel(
            true, "Successfully fetched fetchSearchProduct products");
      } else {
        log("searchProductList list else : ${searchProductList.length}");

        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Error: $e");
      log("****** Error ****** $e", name: "fetchSearchProduct");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
