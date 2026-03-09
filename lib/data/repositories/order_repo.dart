import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class OrderRepo {
  final ApiClient apiClient;
  const OrderRepo({required this.apiClient});

  Future<Response> postCheckout({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.postCheckOut,
        "postCheckout",
        data,
      );
  Future<Response> postPayOrderWalled(
          {required int? orderId, required FormData data}) async =>
      await apiClient.postData(
        "${AppConstants.postPayOrderWalled}/$orderId",
        "postPayOrderWalled",
        data,
      );

  Future<Response> fetchOrder() async => await apiClient.getData(
        AppConstants.getOrder,
        "fetchOrder",
      );

  Future<Response> checkOrderIUPIntentStatusForProductPayment(
          {required String? merchantOrderId}) async =>
      await apiClient.getData(
        "${AppConstants.getCheckUPiIntentStatusForProductPayment}/$merchantOrderId",
        "checkOrderIUPIntentStatusForProductPayment",
      );

  Future<Response> checkoutOrderIUPIntentProductPayment(
          {required int? orderId, required FormData data}) async =>
      await apiClient.postData(
        "${AppConstants.postCheckoutUPiIntentForProductPayment}/$orderId",
        "checkoutOrderIUPIntentProductPayment",
        data,
      );

  Future<Response> checkoutOrderIUPIntentSubscriptionPayment(
          {required int? subscriptionId, required FormData data}) async =>
      await apiClient.postData(
        "${AppConstants.postCheckUPiIntentForSubscriptionPayment}/$subscriptionId",
        "checkoutOrderIUPIntentSubscriptionPayment",
        data,
      );

  Future<Response> checkOrderIUPIntentStatusForProductSubscription(
          {required String? merchantOrderId}) async =>
      await apiClient.getData(
        "${AppConstants.getCheckUPiIntentForSubscriptionPaymentStatus}/$merchantOrderId",
        "checkOrderIUPIntentStatusForProductSubscription",
      );

  Future<Response> checkoutDynamicQRSubscriptionPayment(
          {required int? orderId, required FormData data}) async =>
      await apiClient.postData(
        "${AppConstants.postDynamicQRSubscriptionPayment}/$orderId",
        "checkoutDynamicQRSubscriptionPayment",
        data,
      );
}
