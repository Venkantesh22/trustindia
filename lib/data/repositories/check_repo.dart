import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class CheckoutRepo {
  final ApiClient apiClient;
  const CheckoutRepo({required this.apiClient});

  Future<Response> postCheckout({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.postCheckOut,
        "postCheckout",
        data,
      );
  Future<Response> postPayOrderWalled({required int? orderId}) async =>
      await apiClient.postData(
        "${AppConstants.postPayOrderWalled}/$orderId",
        "postPayOrderWalled",
        "",
      );

  Future<Response> fetchOrder() async => await apiClient.getData(
        AppConstants.getOrder,
        "fetchOrder",
      );
}
