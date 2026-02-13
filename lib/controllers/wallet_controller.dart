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

enum WalletFilterType { none, date, amount }

class WalletController extends GetxController implements GetxService {
  final WallerRepo wallerRepo;
  WalletController({required this.wallerRepo});
  bool isLoading = false;

  final PaginationState<TransactionModel> walletTxnState =
      PaginationState<TransactionModel>();

  /// UI should ALWAYS read from this
  List<TransactionModel> get transactionList => walletTxnState.items;

  WalletFilterType _activeFilter = WalletFilterType.none;
  String? _filterValue;

  /// MAIN FUNCTION (use everywhere)
  Future<ResponseModel> fetchWalletTransaction({
    bool refresh = false,
    bool loadMore = false,
    WalletFilterType filterType = WalletFilterType.none,
    String? filterValue,
  }) async {
    try {
      if (refresh) {
        walletTxnState.reset();
      }

      if (loadMore) {
        if (!walletTxnState.canLoadMore || walletTxnState.isMoreLoading) {
          return ResponseModel(false, "No more pages");
        }
        walletTxnState.page++;
        walletTxnState.isMoreLoading = true;
      } else {
        walletTxnState.isInitialLoading = true;
        walletTxnState.page = 1;
        _activeFilter = filterType;
        _filterValue = filterValue;
      }

      update(['wallet_txn']);

      final Response response = await _fetchByFilter();

      if (response.statusCode == 200 &&
          (response.body['status'] == true ||
              response.body['status'] == 'success')) {
        final transactionsJson = response.body['data']['transactions'];
        final upiJson = response.body['data']['upi_intents'];

        final transactionPagination =
            PaginationModel<TransactionModel>.fromJson(
          transactionsJson,
          (json) => TransactionModel.fromJson(json),
        );

        final upiPagination = PaginationModel<TransactionModel>.fromJson(
          upiJson,
          (json) => TransactionModel.fromJson(json),
        );

        final combinedList = [
          ...transactionPagination.data,
          ...upiPagination.data,
        ];

        /// SORT NEW → OLD
        combinedList.sort((a, b) => (b.createdAt ??
                DateTime.fromMillisecondsSinceEpoch(0))
            .compareTo(a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0)));

        walletTxnState.lastPage = transactionPagination.lastPage;
        walletTxnState.page = transactionPagination.currentPage;

        if (loadMore) {
          for (final item in combinedList) {
            if (!walletTxnState.dedupeIds.contains(item.id)) {
              walletTxnState.dedupeIds.add(item.id);
              walletTxnState.items.add(item);
            }
          }
        } else {
          walletTxnState.items
            ..clear()
            ..addAll(combinedList);

          walletTxnState.dedupeIds
            ..clear()
            ..addAll(combinedList.map((e) => e.id));
        }

        return ResponseModel(true, "Success");
      }

      return ResponseModel(false, "Failed");
    } catch (e) {
      if (loadMore && walletTxnState.page > 1) {
        walletTxnState.page--;
      }
      return ResponseModel(false, e.toString());
    } finally {
      walletTxnState.isInitialLoading = false;
      walletTxnState.isMoreLoading = false;
      update(['wallet_txn']);
    }
  }

  /// Filter router (PRIVATE)
  Future<Response> _fetchByFilter() {
    switch (_activeFilter) {
      case WalletFilterType.date:
        return wallerRepo.fetchWalletTransactionByDate(
          date: _filterValue!,
          page: walletTxnState.page,
        );
      case WalletFilterType.amount:
        return wallerRepo.fetchWalletTransactionByAmount(
          amount: _filterValue!,
          page: walletTxnState.page,
        );
      default:
        return wallerRepo.fetchWalletTransaction(
          page: walletTxnState.page,
        );
    }
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
          response.body['error'] ?? "Something went wrong",
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
        createWalletPin = "";
        createWalletPinConfirm = "";
      } else {
        responseModel = ResponseModel(
          false,
          response.body['error'] ?? " Something went wrong createWalletPin",
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

  Future<ResponseModel> verifyWalletPin() async {
    log('----------- verifyWalletPin Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();
    final data = {
      "old_pin": walletPin,
    };

    try {
      Response response =
          await wallerRepo.verifyWalletPin(data: FormData(data));

      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "verifyWalletPin fetched",
        );
        walletPin = "";
        log("walletPin = $walletPin");
      } else {
        responseModel = ResponseModel(
          false,
          response.body['error'] ?? " Something went wrong verifyWalletPin",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "verifyWalletPin");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> postWalletReSetPin() async {
    log('----------- postWalletReSetPin Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();
    final data = {
      "new_pin": createWalletPin,
      "confirm_pin": createWalletPinConfirm,
    };

    try {
      Response response =
          await wallerRepo.postWalletReSetPin(data: FormData(data));

      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "postWalletReSetPin fetched",
        );
        createWalletPin = "";
        createWalletPinConfirm = "";
      } else {
        responseModel = ResponseModel(
          false,
          response.body['error'] ?? " Something went wrong postWalletReSetPin",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "postWalletReSetPin");
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

  TextEditingController walletSearchController = TextEditingController();

  void setWalletSearchController(String value) {
    walletSearchController.text = value;
    update();
  }

  List<TransactionModel> filerTransactionModel = [];
  Future<ResponseModel> fetchWalletTransactionByDate(String date) async {
    log('----------- fetchWalletTransactionByDate Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    filerTransactionModel.clear();
    update();

    try {
      Response response =
          await wallerRepo.fetchWalletTransactionByDate(date: date);

      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "fetchWalletTransactionByDate fetched",
        );
      } else {
        responseModel = ResponseModel(
          false,
          response.body['error'] ??
              " Something went wrong fetchWalletTransactionByDate",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** fetchWalletTransactionByDate ****** $e",
          name: "fetchWalletTransactionByDate");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> fetchWalletTransactionByAmount(String amount) async {
    log('----------- fetchWalletTransactionByAmount Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response =
          await wallerRepo.fetchWalletTransactionByAmount(amount: amount);

      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "fetchWalletTransactionByAmount fetched",
        );
      } else {
        responseModel = ResponseModel(
          false,
          response.body['error'] ??
              " Something went wrong fetchWalletTransactionByAmount",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** fetchWalletTransactionByAmount ****** $e",
          name: "fetchWalletTransactionByAmount");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
