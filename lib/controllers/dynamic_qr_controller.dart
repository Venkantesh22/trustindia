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
      Response response = await dynamicQrRepo.postGenerateDynamicQR(
          orderId: Get.find<OrderController>().orderId);

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

  Future<ResponseModel> checkPaymentStatus() async {
    log('----------- checkPaymentStatus Called ----------');

    ResponseModel responseModel;
    // isLoading = true;
    // update();

    try {
      Map<String, dynamic> data = {
        'gateway_order_id': dynamicModel?.orderId,
      };

      Response response =
          await dynamicQrRepo.checkPaymentStatus(data: FormData(data));

      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel = ResponseModel(
            true, response.body['message'] ?? " checkPaymentStatus success");
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while checkPaymentStatus user");
      }
    } catch (e) {
      log('ERROR AT checkPaymentStatus(): $e');
      responseModel =
          ResponseModel(false, "Error while checkPaymentStatus user $e");
    }

    // isLoading = false;
    // update();
    return responseModel;
  }
}
