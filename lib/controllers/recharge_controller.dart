import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/wallet_controller.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/models/service/network_service_model.dart';
import 'package:lekra/data/repositories/recharge_repo.dart';
import 'package:lekra/views/base/custom_image.dart';

class RechargeController extends GetxController implements GetxService {
  final RechargeRepo rechargeRepo;

  RechargeController({required this.rechargeRepo});

  bool isLoading = false;
  TextEditingController mobileNoController = TextEditingController();

  NetworkServiceModel? selectNetworkOperate;

  List<NetworkServiceModel> networkServiceModelList = [
    NetworkServiceModel(
        networkName: "AirTel", operatorId: "1", logo: Assets.imagesAritelLogo),
    NetworkServiceModel(
        networkName: "BSNL", operatorId: "2", logo: Assets.imagesBSNLLogo),
    NetworkServiceModel(
        networkName: "Jio", operatorId: "167", logo: Assets.imagesJioLogo),
    NetworkServiceModel(
        networkName: "Vodafone",
        operatorId: "5",
        logo: Assets.imagesVodafoneLogo),
  ];

  TextEditingController rechargeAmountController = TextEditingController();

  Future<ResponseModel> mobileRecharge() async {
    log('----------- mobileRecharge Called() -------------');
    ResponseModel responseModel = ResponseModel(false, "Unknown error");
    isLoading = true;
    update();

    try {
      final walletController = Get.find<WalletController>();
      Map<String, dynamic> data = {
        'mobile': mobileNoController.text.trim(),
        'amount': rechargeAmountController.text.trim(),
        'operator_id': selectNetworkOperate?.operatorId,
        "wallet_pin": walletController.walletPin,
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
          response.body['message'] ??
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
