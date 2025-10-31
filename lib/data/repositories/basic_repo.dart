import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class BasicRepo {
  final ApiClient apiClient;
  const BasicRepo({required this.apiClient});

  Future<Response> getBanner() async =>
      await apiClient.getData(AppConstants.bannerUri, "getBanner");

 
  Future<Response> fetchAddress() async =>
      await apiClient.getData(AppConstants.getAddress, "fetchAddress");

  Future<Response> addAddress({required FormData data}) async => await apiClient
      .postData(AppConstants.postAddAddress, "postAddAddress", data);

  Future<Response> deletesAddress({required int? addressId}) async =>
      await apiClient.postData(
          "${AppConstants.postDeleteAddress}/$addressId", "deletesAddress", "");

  Future<Response> fetchAddressById({required int? addressId}) async =>
      await apiClient.getData(AppConstants.getAddressById, "fetchAddressById");
}
