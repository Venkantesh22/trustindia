import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class FundRequestRepo {
  final ApiClient apiClient;
  FundRequestRepo({required this.apiClient});

  Future<Response> getAssignBank() async =>
      await apiClient.getData(AppConstants.getAssignBank, "getAssignBank");
}
