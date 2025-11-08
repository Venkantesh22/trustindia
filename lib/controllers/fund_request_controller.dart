import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/fund_reqests/bank_model.dart';
import 'package:lekra/data/models/fund_reqests/fund_ruquest_model.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/fund_request_repo.dart';

class FundRequestController extends GetxController implements GetxService {
  final FundRequestRepo fundRequestRepo;
  FundRequestController({required this.fundRequestRepo});

  bool isLoading = false;

  final TextEditingController utrNoController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  BankModel? selectedBank;

  void setBank(String? value) {
    selectedBank = bankList.firstWhere((bank) => bank.accountName == value);
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
        selectedBank = bankList.first;
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

  Future<ResponseModel> postFundRequest() async {
    log('-----------  postFundRequest() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    Map<String, dynamic> data = {
      "bank_id": selectedBank?.id ?? "",
      "amount": amountController.text.trim(),
      "trans_date": dateController.text.trim(),
      "utr": utrNoController.text.trim(),
    };

    try {
      Response response =
          await fundRequestRepo.postFundRequest(data: FormData(data));

      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel =
            ResponseModel(true, response.body['message'] ?? "postFundRequest");

        selectedBank = null;
        amountController.clear();
        dateController.clear();
        utrNoController.clear();
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "postFundRequest Something Went Wrong");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "postFundRequest");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  List<FundRequestsModel> fundRequestsList = [];
  Future<ResponseModel> fetchFundStatus() async {
    log('-----------  fetchFundStatus() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await fundRequestRepo.fetchFundStatus();

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is List) {
        fundRequestsList = (response.body['data'] as List)
            .map((fund) => FundRequestsModel.fromJson(fund))
            .toList();
      
        responseModel =
            ResponseModel(true, response.body['message'] ?? "fetchFundStatus");
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "fetchFundStatus Something Went Wrong");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchFundStatus");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
