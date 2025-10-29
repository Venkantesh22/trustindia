import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class SubscriptionRepo {
  final ApiClient apiClient;
  SubscriptionRepo({required this.apiClient});

  Future<Response> fetchSubscriptionPlan() async => await apiClient.getData(
      AppConstants.getSubscription, "fetchSubscriptionPlan");
}
