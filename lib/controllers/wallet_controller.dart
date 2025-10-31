import 'dart:developer';

import 'package:get/get.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/models/transaction_model.dart.dart';
import 'package:lekra/data/repositories/wallet_repo.dart';

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
}
