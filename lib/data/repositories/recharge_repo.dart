import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class RechargeRepo {
  final ApiClient apiClient;

  RechargeRepo({required this.apiClient});

  Future<Response> mobileRecharge({required FormData? data}) async =>
      await apiClient.postData(
        AppConstants.postRecharge,
        "mobileRecharge",
        data,
      );
}
