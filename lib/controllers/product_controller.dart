import 'dart:developer';

import 'package:get/get.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/product_repo.dart';

class ProductController extends GetxController implements GetxService {
  final ProductRepo categoryRepo;
  ProductController({required this.categoryRepo});
  bool isLoading = false;

  List<ProductModel> cateProductList = [];
  Future<ResponseModel> fetchCategory({required int? categoryId}) async {
    log('-----------  fetchCategory() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response =
          await categoryRepo.fetchCategoryDetails(categoryId: categoryId);

      if (response.statusCode == 200 &&
          response.body['success'] == true &&
          response.body['data']['products'] is List) {
        cateProductList = (response.body['data']['products'] as List)
            .map((product) => ProductModel.fromJson(product))
            .toList();

        log("Product length ${cateProductList.length}");

        responseModel =
            ResponseModel(true, response.body['message'] ?? "fetchCategory");
      } else {
        log("Product length else ${cateProductList.length}");
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Something Went Wrong");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchCategory");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  ProductModel? productModel;
  Future<ResponseModel> fetchProduct({required int? productId}) async {
    log('-----------  fetchProduct() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response =
          await categoryRepo.fetchProductDetails(productId: productId);

      if (response.statusCode == 200 &&
          response.body['success'] == true &&
          response.body['data'] is Map) {
        // cateProductList = (response.body['data'] as List)
        //     .map((product) => ProductModel.fromJson(product))
        //     .toList();
        productModel = ProductModel.fromJson(response.body['data']);

        // log("Product length ${cateProductList.length}");

        responseModel =
            ResponseModel(true, response.body['message'] ?? "fetchProduct");
      } else {
        // log("Product length else ${cateProductList.length}");
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Something Went Wrong");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchProduct");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  // Future<ResponseModel> fetchCategory({required int? categoryId}) async {
  //   log('-----------  fetchCategory() -------------');
  //   ResponseModel responseModel;
  //   isLoading = true;
  //   update();

  //   try {
  //     Response response =
  //         await categoryRepo.fetchCategoryDetails(categoryId: categoryId);
  //     if (response.statusCode == 200 &&
  //         response.body['status'] == true &&
  //         response.body['data']['products'] is List) {
  //       cateProductList = (response.body['data']['products'] as List)
  //           .map((product) => ProductModel.fromJson(product))
  //           .toList();

  //       log("Product length ${cateProductList.length}");

  //       responseModel =
  //           ResponseModel(true, response.body['message'] ?? "fetchCategory");
  //     } else {
  //               log("Product length else ${cateProductList.length}");

  //       responseModel = ResponseModel(
  //           false, response.body['message'] ?? "Something Went Wrong");
  //     }
  //   } catch (e) {
  //     responseModel = ResponseModel(false, "Catch");
  //     log("****** Error ****** $e", name: "fetchCategory");
  //   }

  //   isLoading = false;
  //   update();
  //   return responseModel;
  // }
}
