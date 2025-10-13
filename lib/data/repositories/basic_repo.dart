import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class BasicRepo {
  final ApiClient apiClient;
  const BasicRepo({required this.apiClient});

  Future<Response> getBanner() async =>
      await apiClient.getData(AppConstants.bannerUri, "getBanner");
}
