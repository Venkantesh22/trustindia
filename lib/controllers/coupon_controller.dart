import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/coupon_repo.dart';

class CouponController extends GetxController implements GetxService {
  final CouponRepo couponRepo;
  CouponController({required this.couponRepo});

  bool isLoading = false;

  TextEditingController couponCodeController = TextEditingController();
  String couponCode = "";
  Future<ResponseModel> validateCouponController() async {
    log('----------- validateCouponController Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    couponCode = couponCodeController.text.trim();
    try {
      Map<String, dynamic> data = {
        "code": couponCodeController.text.trim(),
      };

      log("code : ${couponCodeController.text.trim()}");
      Response response = await couponRepo.postCouponCode(data: FormData(data));

      if (response.body['status'] == true) {
        responseModel = ResponseModel(true,
            response.body['message'] ?? "validateCouponController success");
        await Get.find<ProductController>()
            .fetchCard(couponCode: couponCodeController.text.trim());
        couponCodeController.clear();
      } else {
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Error while validateCouponController user");
      }
    } catch (e) {
      log('ERROR AT validateCouponController(): $e');
      responseModel =
          ResponseModel(false, "Error while validateCouponController user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
