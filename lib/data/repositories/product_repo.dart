import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class ProductRepo {
  final ApiClient apiClient;
  const ProductRepo({required this.apiClient});

  Future<Response> fetchCategoryDetails({required int? categoryId}) async =>
      await apiClient.getData("${AppConstants.getCategoryDetails}/$categoryId",
          "fetchCategoryDetails");
  Future<Response> fetchProductDetails({required int? productId}) async =>
      await apiClient.getData("${AppConstants.getProductDetails}/$productId",
          "fetchProductDetails");

  Future<Response> postAddToCard(
          {required FormData data, required int? productId}) async =>
      await apiClient.postData(
        "${AppConstants.postAddToCard}/$productId",
        "postAddToCard",
        data,
      );

  Future<Response> postRemoveToCard({required int? productId}) async =>
      await apiClient.postData(
        AppConstants.postRemoveToCard,
        "postRemoveToCard",
        {"product_id": productId ?? ""},
      );

  Future<Response> fetchCard() async =>
      await apiClient.getData(AppConstants.getCard, "fetchCard");
}
