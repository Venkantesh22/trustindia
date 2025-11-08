import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/fund_reqests/bank_model.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/fund_request_repo.dart';

class FundRequestController extends GetxController implements GetxService {
  final FundRequestRepo fundRequestRepo;
  FundRequestController({required this.fundRequestRepo});

  bool isLoading = false;

  final TextEditingController utrNoController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String? selectedBank;

  void setBank(String? value) {
    selectedBank = value;
    update();
  }

  @override
  void onClose() {
    utrNoController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.onClose();
  }

  List<BankModel> bankList = [];
  Future<ResponseModel> getAssignBank() async {
    log('-----------  getAssignBank() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await fundRequestRepo.getAssignBank();

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is List) {
        bankList = (response.body['data'] as List)
            .map((bank) => BankModel.fromJson(bank))
            .toList();
        selectedBank = bankList.first.accountName;
        responseModel =
            ResponseModel(true, response.body['message'] ?? "getAssignBank");
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "getAssignBank Something Went Wrong");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "getAssignBank");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
