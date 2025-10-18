import 'dart:developer';

import 'package:get/get.dart';
import 'package:lekra/data/models/card_model.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/product_repo.dart';

class ProductController extends GetxController implements GetxService {
  final ProductRepo productRepo;
  ProductController({required this.productRepo});
  bool isLoading = false;

  List<ProductModel> cateProductList = [];
  Future<ResponseModel> fetchCategory({required int? categoryId}) async {
    log('-----------  fetchCategory() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response =
          await productRepo.fetchCategoryDetails(categoryId: categoryId);

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
          await productRepo.fetchProductDetails(productId: productId);

      if (response.statusCode == 200 &&
          response.body['success'] == true &&
          response.body['data'] is Map) {
        productModel = ProductModel.fromJson(response.body['data']);

        responseModel =
            ResponseModel(true, response.body['message'] ?? "fetchProduct");
      } else {
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

  Future<ResponseModel> postAddToCard({required ProductModel? product}) async {
    log('----------- postAddToCard Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "productName": product?.name ?? "",
        "productPrice": product?.discountedPrice ?? "",
        "productId": product?.id ?? "",
      };
      log("Disc price ${product?.discountedPrice}");
      Response response = await productRepo.postAddToCard(
          data: FormData(data), productId: product?.id);

      if (response.body['status'] == true) {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "Add to Card success");
        await fetchCard();
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while postAddToCard user");
      }
    } catch (e) {
      log('ERROR AT postAddToCard(): $e');
      responseModel = ResponseModel(false, "Error while postAddToCard user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> postRemoveToCard(
      {required ProductModel? product}) async {
    log('----------- postRemoveToCard Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response =
          await productRepo.postRemoveToCard(productId: product?.id);

      if (response.body['status'] == true) {
        responseModel = ResponseModel(true,
            response.body['message'] ?? "remove to postRemoveToCard success");
        await fetchCard();
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while postRemoveToCard user");
      }
    } catch (e) {
      log('ERROR AT postRemoveToCard(): $e');
      responseModel =
          ResponseModel(false, "Error while postRemoveToCard user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  CardModel? cardModel;

  Future<ResponseModel> fetchCard() async {
    log('-----------  fetchCard() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await productRepo.fetchCard();

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is Map) {
        cardModel = CardModel.fromJson(response.body["data"]);

        log("cardModelList length ${cardModel?.products?.length} ");

        responseModel =
            ResponseModel(true, response.body['message'] ?? "fetchCard");
      } else {
        log("cardModelList length else ");
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Something Went Wrong");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchCard");
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
