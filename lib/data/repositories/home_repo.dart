import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class HomeRepo {
  final ApiClient apiClient;
  const HomeRepo({required this.apiClient});

  Future<Response> getCategory() async =>
      await apiClient.getData(AppConstants.categoryList, "getCategory");

  Future<Response> getFeaturedProducts() async =>
      await apiClient.getData(AppConstants.getFeaturedProducts, "featuredProducts");
}
