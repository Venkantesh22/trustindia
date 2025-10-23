import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/body/address_model.dart';
import 'package:lekra/data/models/home/banner_model';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/models/transaction_model.dart.dart';
import 'package:lekra/data/repositories/basic_repo.dart';

class BasicController extends GetxController implements GetxService {
  final BasicRepo basicRepo;

  BasicController({required this.basicRepo});

  bool isLoading = false;

  List<BannerModel> sliders = [];

  Future<ResponseModel> fetchHomeBanner() async {
    log('----------- fetchHomeBanner Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await basicRepo.getBanner();
      log("Raw Response: ${response.body}");

      // ✅ Correct key is 'status'
      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is List) {
        // ✅ Parse banners
        sliders = (response.body['data'] as List)
            .map((item) => BannerModel.fromJson(item))
            .toList();

        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "Banners fetched",
        );
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchHomeBanner");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  List<TransactionModel> transactionList = [];
  Future<ResponseModel> fetchWalletTransaction() async {
    log('----------- fetchWalletTransaction Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await basicRepo.fetchWalletTransaction();
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

  AddressModel? selectAddress;
  List<AddressModel> addressList = [];
  Future<ResponseModel> fetchAddress() async {
    log('----------- fetchAddress Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await basicRepo.fetchAddress();
      // log("Raw Response: ${response.body}");

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is List) {
        addressList = (response.body['data'] as List)
            .map((item) => AddressModel.fromJson(item))
            .toList();
        selectAddress = addressList.first;

        // log("addressList length: ${addressList.length}");

        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "fetchAddress fetched",
        );
      } else {
        // log("addressList length else: ${addressList.length}");

        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchAddress");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  void updateSelectAddress(AddressModel value) {
    selectAddress = value;
    update();
  }

  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  Future<ResponseModel> addAddress() async {
    log('----------- addAddress Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "street": streetController.text.trim(),
        "city": cityController.text.trim(),
        "state": stateController.text.trim(),
        "pincode": pincodeController.text.trim(),
      };

      Response response = await basicRepo.addAddress(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "addAddress add successfully ");
        streetController.clear();
        cityController.clear();
        stateController.clear();
        pincodeController.clear();
        fetchAddress();
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while addAddress user");
        fetchAddress();
      }
    } catch (e) {
      log('ERROR AT addAddress(): $e');
      responseModel = ResponseModel(false, "Error while addAddress user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> deleteAddress({required int? addressId}) async {
    log('----------- deleteAddress Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await basicRepo.deletesAddress(addressId: addressId);

      log("Raw Response: ${response.body}");

      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "deleteAddress successfully ");

        fetchAddress();
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while deleteAddress ");
      }
    } catch (e) {
      log('ERROR AT deleteAddress(): $e');
      responseModel = ResponseModel(false, "Error while deleteAddress $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  AddressModel? orderAddress;
  Future<ResponseModel> fetchAddressId({required int? addressId}) async {
    log('----------- fetchAddressId Called() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response =
          await basicRepo.fetchAddressById(addressId: addressId);
      log("Raw Response: ${response.body}");

      // ✅ Correct key is 'status'
      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is Map) {
        orderAddress = AddressModel.fromJson(response.body['data']);

        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "fetchAddressId fetched",
        );
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchAddressId");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
