import 'dart:developer';

import 'package:get/get.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/data/models/dynamic_model.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/models/service/mobile_recharge_service_models/dynamic_for_reacharge_moble.dart';
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
      Response response = await dynamicQrRepo.postGenerateDynamicQR(
          orderId: Get.find<OrderController>().orderId);

      if (response.statusCode == 200 && response.body['status'] == true) {
        dynamicModel = DynamicModel.fromJson(response.body['data']);
        responseModel = ResponseModel(
            true, response.body['message'] ?? " dynamicQR success");
      } else {
        responseModel = ResponseModel(
            false, response.body['error'] ?? "Error while dynamicQR user");
      }
    } catch (e) {
      log('ERROR AT dynamicQR(): $e');
      responseModel = ResponseModel(false, "Error while dynamicQR user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  bool isDynamicQRPaymentDone = false;
  Future<ResponseModel> checkPaymentStatus() async {
    log('----------- checkPaymentStatus Called ----------');

    ResponseModel responseModel;

    try {
      Map<String, dynamic> data = {
        'gateway_order_id': dynamicModel?.orderId,
      };

      Response response =
          await dynamicQrRepo.checkPaymentStatus(data: FormData(data));

      if (response.statusCode == 200 && response.body['status'] == true) {
        isDynamicQRPaymentDone =
            response.body['transaction_status'] == "success" ? true : false;

        responseModel = ResponseModel(
            true, response.body['message'] ?? " checkPaymentStatus success");
      } else {
        responseModel = ResponseModel(false,
            response.body['error'] ?? "Error while checkPaymentStatus user");
      }
    } catch (e) {
      log('ERROR AT checkPaymentStatus(): $e');
      responseModel =
          ResponseModel(false, "Error while checkPaymentStatus user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> checkoutDynamicQRSubscriptionPayment({
    required int? subscriptionID,
  }) async {
    log('----------- checkoutDynamicQRSubscriptionPayment Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    Map<String, dynamic> data = {};

    try {
      Response response =
          await dynamicQrRepo.checkoutDynamicQRSubscriptionPayment(
              subscriptionID: subscriptionID, data: FormData(data));

      if (response.statusCode == 200 && response.body['status'] == true) {
        dynamicModel = DynamicModel.fromJson(response.body['data']);

        responseModel = ResponseModel(
            true,
            response.body['message'] ??
                " checkoutDynamicQRSubscriptionPayment success");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['error'] ??
                "Error while checkoutDynamicQRSubscriptionPayment user");
      }
    } catch (e) {
      log('ERROR AT checkoutDynamicQRSubscriptionPayment(): $e');
      responseModel = ResponseModel(
          false, "Error while checkoutDynamicQRSubscriptionPayment user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> checkDynamicQRSubscriptionPaymentStatus() async {
    log('----------- checkDynamicQRSubscriptionPaymentStatus Called ----------');

    ResponseModel responseModel;

    try {
      Response response =
          await dynamicQrRepo.checkDynamicQRSubscriptionPaymentStatus(
              orderID: dynamicModel?.orderId);

      if (response.statusCode == 200 && response.body['status'] == true) {
        isDynamicQRPaymentDone =
            response.body['transaction_status'] == "success" ? true : false;

        responseModel = ResponseModel(
            true,
            response.body['message'] ??
                " checkDynamicQRSubscriptionPaymentStatus success");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['error'] ??
                "Error while checkDynamicQRSubscriptionPaymentStatus user");
      }
    } catch (e) {
      log('ERROR AT checkPaymentStatus(): $e');
      responseModel = ResponseModel(
          false, "Error while checkDynamicQRSubscriptionPaymentStatus user $e");
    }

    // isLoading = false;
    // update();
    return responseModel;
  }

  DynamicForRechargeMobile? dynamicForRechargeMobile;
  Future<ResponseModel> fetchDynamicForMobileRecharge({
    required String mobileNumber,
    required String operatorId,
    required String amount,
  }) async {
    log('----------- fetchDynamicForMobileRecharge Called() -------------');

    ResponseModel responseModel = ResponseModel(false, "Unknown error");
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "mobile": mobileNumber,
        'operator_id': operatorId,
        'amount': amount,
      };

      Response response = await dynamicQrRepo.fetchDynamicForMobileRecharge(
        data: FormData(data),
      );

      if (response.statusCode == 200 && (response.body['status'] == true)) {
        dynamicForRechargeMobile =
            DynamicForRechargeMobile.fromJson(response.body['data']);

        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "Success fetchDynamicForMobileRecharge",
        );
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ??
              "Something went wrong fetchDynamicForMobileRecharge",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch error");
      log("****** Error ****** $e", name: "fetchDynamicForMobileRecharge");
    }

    isLoading = false;
    update();

    return responseModel;
  }
}
