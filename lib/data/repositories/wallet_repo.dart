import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class WallerRepo {
  final ApiClient apiClient;
  WallerRepo({required this.apiClient});

  Future<Response> fetchWalletTransaction() async => await apiClient.getData(
      AppConstants.getWalletTransaction, "fetchWalletTransaction");

  Future<Response> fetchWallet() async =>
      await apiClient.getData(AppConstants.getWallet, "fetchWallet");

  Future<Response> createWalletPin({required FormData data}) async =>
      await apiClient.postData(AppConstants.postWalletPin, "fetchWallet", data);
}
