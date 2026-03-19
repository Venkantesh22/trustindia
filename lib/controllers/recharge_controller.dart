import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/models/service/network_service_model.dart';
import 'package:lekra/data/repositories/recharge_repo.dart';

class RechargeController extends GetxController implements GetxService {
  final RechargeRepo rechargeRepo;

  RechargeController({required this.rechargeRepo});

  bool isLoading = false;
  TextEditingController mobileNoController = TextEditingController();

  NetworkServiceModel? selectNetworkOperate;

  List<NetworkServiceModel> networkServiceModelList = [
    NetworkServiceModel(networkName: "AirTel", operatorId: "1"),
    NetworkServiceModel(networkName: "BSNL", operatorId: "2"),
    NetworkServiceModel(networkName: "Jio", operatorId: "167"),
    NetworkServiceModel(networkName: "Vodafone", operatorId: "5"),
  ];

  TextEditingController rechargeAmountController = TextEditingController();

  Future<ResponseModel> mobileRecharge() async {
    log('----------- mobileRecharge Called() -------------');
    ResponseModel responseModel = ResponseModel(false, "Unknown error");
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        'mobile': mobileNoController.text.trim(),
        'amount': rechargeAmountController.text.trim(),
        'operator_id': selectNetworkOperate?.operatorId,
      };

      Response response =
          await rechargeRepo.mobileRecharge(data: FormData(data));

      // ✅ Correct key is 'status'
      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel = ResponseModel(
            true,
            response.body['message'] ??
                "Success fetch fetchReferralLevelDataByID");
      } else {
        responseModel = ResponseModel(
          false,
          response.body['error'] ??
              "Something went wrong fetchReferralLevelDataByID",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchReferralLevelDataByID");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
