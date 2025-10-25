import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class ReferralRepo {
  final ApiClient apiClient;
  const ReferralRepo({required this.apiClient});

  Future<Response> fetchReferral() async =>
      await apiClient.getData(AppConstants.getReferral, "fetchReferral");

  Future<Response> fetchScratchCard() async =>
      await apiClient.getData(AppConstants.fetchScratchCard, "fetchScratchCard");
}
