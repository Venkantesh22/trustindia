import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/pagination/pagination_model.dart';
import 'package:lekra/data/models/pagination/pagination_state.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/models/transaction_model.dart.dart';
import 'package:lekra/data/models/wallet_model.dart';
import 'package:lekra/data/repositories/wallet_repo.dart';
import 'package:lekra/views/screens/dashboard/dashboard_screen.dart';

class WalletController extends GetxController implements GetxService {
  final WallerRepo wallerRepo;
  WalletController({required this.wallerRepo});
  bool isLoading = false;

  final PaginationState<TransactionModel> fetchWalletTransactionState =
      PaginationState<TransactionModel>();

  List<TransactionModel> get transactionList =>
      fetchWalletTransactionState.items;

  // List<TransactionModel> transactionList = [];
  Future<ResponseModel> fetchWalletTransaction({
    bool loadMore = false,
    bool refresh = false,
  }) async {
    log('fetchWalletTransaction called (loadMore: $loadMore, refresh: $refresh)');
    ResponseModel responseModel;
    if (refresh) {
      fetchWalletTransactionState.reset();
      fetchWalletTransactionState.page = 1;
    }
    if (loadMore) {
      if (!fetchWalletTransactionState.canLoadMore) {
        return ResponseModel(false, "No more pages");
      }
      // prepare for next page
      fetchWalletTransactionState.page += 1;
      fetchWalletTransactionState.isMoreLoading = true;
    } else {
      // initial load (or refresh)
      fetchWalletTransactionState.isInitialLoading = true;
      fetchWalletTransactionState.page = 1;
    }

    isLoading = true;
    update();

    try {
      Response response = await wallerRepo.fetchWalletTransaction(
        page: fetchWalletTransactionState.page,
      );

      if (response.statusCode == 200 && response.body['status'] == true) {
        final pagination = PaginationModel<TransactionModel>.fromJson(
          response.body['data']['transactions'],
          (json) => TransactionModel.fromJson(json),
        );

        fetchWalletTransactionState.lastPage = pagination.lastPage;
        fetchWalletTransactionState.page = pagination.currentPage;

        //    // update canLoadMore
        // fetchWalletTransactionState. =
        //     fetchWalletTransactionState.page < fetchWalletTransactionState.lastPage;

        if (loadMore) {
          // dedupe by id (if your ProductModel has `id`)
          for (final p in pagination.data) {
            if (!fetchWalletTransactionState.dedupeIds.contains(p.id)) {
              fetchWalletTransactionState.dedupeIds.add(p.id);
              fetchWalletTransactionState.items.add(p);
            }
          }
        } else {
          fetchWalletTransactionState.items
            ..clear()
            ..addAll(pagination.data);
          fetchWalletTransactionState.dedupeIds.clear();
          fetchWalletTransactionState.dedupeIds
              .addAll(pagination.data.map((e) => e.id));
        }

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
      if (loadMore && fetchWalletTransactionState.page > 1) {
        fetchWalletTransactionState.page -= 1;
      }
    } finally {
      fetchWalletTransactionState.isInitialLoading = false;
      fetchWalletTransactionState.isMoreLoading = false;
      isLoading = false;

      update();
    }

    return responseModel;
  }

  WalletModel? walletModel;
  Future<ResponseModel> fetchWallet() async {
    log('----------- fetchWallet Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await wallerRepo.fetchWallet();

      if (response.statusCode == 200 && response.body['status'] == true) {
        walletModel = WalletModel(wallet: response.body['wallet'].toString());
        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "fetchWallet fetched",
        );
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchWallet");
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
