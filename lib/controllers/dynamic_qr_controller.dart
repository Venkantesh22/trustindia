import 'dart:developer';

import 'package:get/get.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/data/models/dynamic_model.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/dynamic_qr_repo.dart';

class DynamicQRController extends GetxController implements GetxService {
  final DynamicQrRepo dynamicQrRepo;
  DynamicQRController({required this.dynamicQrRepo});
  bool isLoading = false;

  DynamicModel? dynamicModel;
  Future<ResponseModel> dynamicQR() async {
    log('----------- dynamicQR Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "callback_url": "https://ecom.tpipaygroup.com/api/tpipay/callback",
      };

      Response response = await dynamicQrRepo.postGenerateDynamicQR(
          orderId: Get.find<OrderController>().orderId, data: FormData(data));

      if (response.statusCode == 200 && response.body['status'] == true) {
        dynamicModel = DynamicModel.fromJson(response.body['data']);
        responseModel = ResponseModel(
            true, response.body['message'] ?? " dynamicQR success");
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while dynamicQR user");
      }
    } catch (e) {
      log('ERROR AT dynamicQR(): $e');
      responseModel = ResponseModel(false, "Error while dynamicQR user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}



// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lekra/controllers/order_controlller.dart';
// import 'package:lekra/data/models/dynamic_model.dart';
// import 'package:lekra/data/models/response/response_model.dart';
// import 'package:lekra/data/repositories/dynamic_qr_repo.dart';
// import 'package:lekra/services/constants.dart';
// import 'package:lekra/services/theme.dart' as Colors;

// class DynamicQRController extends GetxController {
//   final DynamicQrRepo dynamicQrRepo;
//   DynamicQRController({required this.dynamicQrRepo});

//   bool isLoading = false;
//   DynamicModel? dynamicModel;

//   Timer? _pollTimer;
//   int _pollAttempts = 0;
//   final int _maxAttempts = 20; // e.g., stop after 20 tries
//   final Duration _pollInterval = const Duration(seconds: 3);

//   Future<ResponseModel> dynamicQR() async {
//     log('----------- dynamicQR Called ----------');
//     ResponseModel responseModel;
//     isLoading = true;
//     update();

//     try {
//       Map<String, dynamic> data = {
//         "callback_url": AppConstants.postCallBack,
//       };

//       final response = await dynamicQrRepo.postGenerateDynamicQR(
//           orderId: Get.find<OrderController>().orderId, data: FormData(data));

//       if (response.statusCode == 200 && response.body['status'] == true) {
//         dynamicModel = DynamicModel.fromJson(response.body['data']);
//         responseModel = ResponseModel(
//             true, response.body['message'] ?? " dynamicQR success");

//         // Start polling order status as soon as QR is generated
//         _startPollingOrderStatus(dynamicModel!.orderId);
//       } else {
//         responseModel = ResponseModel(
//             false, response.body['message'] ?? "Error while dynamicQR user");
//       }
//     } catch (e) {
//       log('ERROR AT dynamicQR(): $e');
//       responseModel = ResponseModel(false, "Error while dynamicQR user $e");
//     }

//     isLoading = false;
//     update();
//     return responseModel;
//   }

//   void _startPollingOrderStatus(int? orderId) {
//     _pollAttempts = 0;
//     _pollTimer?.cancel();
//     _pollTimer = Timer.periodic(_pollInterval, (timer) async {
//       _pollAttempts++;
//       log('Polling order status attempt: $_pollAttempts for order: $orderId');

//       try {
//         final resp = await dynamicQrRepo.getOrderStatus(orderId: orderId);
//         if (resp.statusCode == 200 && resp.body['status'] == true) {
//           final status = resp.body['data']['payment_status'] ??
//               resp.body['data']['status'];
//           // adapt the key name to your API response; could be 'payment_status', 'status', 'is_paid', etc.
//           if (status == 'paid' || status == 'success' || status == true) {
//             // Payment successful
//             _pollTimer?.cancel();
//             _showSuccessAndNavigate();
//           } else {
//             // still not paid -> do nothing, continue polling
//             if (_pollAttempts >= _maxAttempts) {
//               _pollTimer?.cancel();
//               _onPollingTimeout();
//             }
//           }
//         } else {
//           // error response - optionally stop or continue depending on statusCode
//           if (_pollAttempts >= _maxAttempts) {
//             _pollTimer?.cancel();
//             _onPollingTimeout();
//           }
//         }
//       } catch (e) {
//         log('Error while polling order status: $e');
//         if (_pollAttempts >= _maxAttempts) {
//           _pollTimer?.cancel();
//           _onPollingTimeout();
//         }
//       }
//     });
//   }

//   void _showSuccessAndNavigate() {
//     // show a success message and navigate to success page or update UI
//     Get.snackbar(
//       "Order placed",
//       "🎉 Congratulations! Your order has been placed successfully.",
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.white,
//       colorText: Colors.backgroundLight,
//       boxShadows: [
//         BoxShadow(
//             color: Colors.green.withOpacity(0.4),
//             offset: Offset(0, 4),
//             blurRadius: 6)
//       ],
//     );

//     // optionally navigate to order details or success screen:
//     // Get.offAll(() => OrderSuccessScreen(...));
//   }

//   void _onPollingTimeout() {
//     Get.snackbar("Payment pending",
//         "Payment not received. Please try again or check your bank/app.");
//     // optionally navigate back or allow user to retry
//   }

//   @override
//   void onClose() {
//     _pollTimer?.cancel();
//     super.onClose();
//   }
// }

