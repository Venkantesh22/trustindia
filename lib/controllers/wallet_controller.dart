import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/models/transaction_model.dart.dart';
import 'package:lekra/data/repositories/wallet_repo.dart';
import 'package:lekra/views/screens/dashboard/dashboard_screen.dart';

class WalletController extends GetxController implements GetxService {
  final WallerRepo wallerRepo;
  WalletController({required this.wallerRepo});
  bool isLoading = false;

  List<TransactionModel> transactionList = [];
  Future<ResponseModel> fetchWalletTransaction() async {
    log('----------- fetchWalletTransaction Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await wallerRepo.fetchWalletTransaction();
      // log("Raw Response: ${response.body}");

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data']['transactions'] is Map) {
        transactionList =
            (response.body['data']['transactions']['data'] as List)
                .map((item) => TransactionModel.fromJson(item))
                .toList();

        // log("transactionList length: ${transactionList.length}");

        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "fetchWalletTransaction fetched",
        );
      } else {
        // log("transactionList length else: ${transactionList.length}");

        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchWalletTransaction");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> fetchWallet() async {
    log('----------- fetchWallet Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await wallerRepo.fetchWallet();

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['wallet'] is String) {
        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "fetchWalletTransaction fetched",
        );
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchWalletTransaction");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  String createWalletPin = "";
  String createWalletPinConfirm = "";

  Future<ResponseModel> postCreateWalletPin() async {
    log('----------- createWalletPin Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();
    final data = {
      "wallet_pin": createWalletPin,
      "wallet_pin_confirmation": createWalletPinConfirm,
    };

    try {
      Response response =
          await wallerRepo.createWalletPin(data: FormData(data));

      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "createWalletPin fetched",
        );
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ?? " Something went wrong createWalletPin",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "createWalletPin");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Widget pageFormMove = const DashboardScreen();

  void updatePage(Widget value) {
    pageFormMove = value;
  }

    String walletPin = "";

}
