import 'package:get/get_connect/http/src/multipart/form_data.dart' show FormData;
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class DynamicQrRepo {
  final ApiClient apiClient;
  const DynamicQrRepo({required this.apiClient});

   Future<Response> postGenerateDynamicQR(
          {required int? orderId}) async =>
      await apiClient.postData(
        "${AppConstants.postDynamicQR}/$orderId",
        "postGenerateDynamicQR",
        "",
      );
}

// in dynamic_qr_repo.dart (or order repo)
// import 'package:get/get_connect/http/src/multipart/form_data.dart';
// import 'package:get/get_connect/http/src/response/response.dart';
// import 'package:lekra/data/api/api_client.dart';
// import 'package:lekra/services/constants.dart';

// class DynamicQrRepo {
//   final ApiClient apiClient;
//   const DynamicQrRepo({required this.apiClient});

//   Future<Response> postGenerateDynamicQR(
//           {required int? orderId, required FormData data}) async =>
//       await apiClient.postData(
//           "${AppConstants.postDynamicQR}/$orderId", "postPayOrderWalled", data);

//   // new: fetch order/payment status
//   Future<Response> getOrderStatus({required int? orderId}) async =>
//       await apiClient.postData(
//           "${AppConstants.postCallBack}", "getOrderStatus", "");
// }
