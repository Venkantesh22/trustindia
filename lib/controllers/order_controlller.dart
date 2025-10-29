import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/order_model.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/check_repo.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool isLoading = false;

  TextEditingController billingName = TextEditingController();
  TextEditingController billingEmail = TextEditingController();
  TextEditingController billingNumber = TextEditingController();

  int? orderId;
  Future<ResponseModel> postCheckout({
    required int? addressId,
  }) async {
    log('----------- postCheckout Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "address_id": addressId ?? "",
        "billing_name": billingName.text.trim(),
        "billing_email": billingEmail.text.trim(),
        "billing_phone": billingNumber.text.trim(),
      };

      Response response = await orderRepo.postCheckout(data: FormData(data));

      if (response.statusCode == 200 && response.body['status'] == true) {
        orderId = response.body['order']['id'];
        log("Saved Order ID: $orderId");
        responseModel = ResponseModel(
            true, response.body['message'] ?? " postCheckout success");
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while postCheckout user");
      }
    } catch (e) {
      log('ERROR AT postCheckout(): $e');
      responseModel = ResponseModel(false, "Error while postCheckout user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> postPayOrderWallet({
    required int? orderId,
  }) async {
    log('----------- postPayOrderWallet Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await orderRepo.postPayOrderWalled(orderId: orderId);

      if (response.statusCode == 200 && response.body['status'] == true) {
        responseModel = ResponseModel(
            true, response.body['message'] ?? " postPayOrderWallet success");
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while postPayOrderWallet user");
      }
    } catch (e) {
      log('ERROR AT postPayOrderWallet(): $e');
      responseModel =
          ResponseModel(false, "Error while postPayOrderWallet user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  List<OrderModel> orderList = [];
  List<ProductModel> orderProductList = [];
  Future<ResponseModel> fetchOrder() async {
    log('----------- fetchOrder Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await orderRepo.fetchOrder();

      if (response.statusCode == 200 && response.body['status'] == true) {
        orderList = (response.body["data"] as List)
            .map((order) => OrderModel.fromJson(order))
            .toList();
        // Clear before adding
        orderProductList.clear();

// Extract products from each order
        for (var order in response.body["data"]) {
          if (order["products"] != null) {
            orderProductList.addAll(
              (order["products"] as List)
                  .map((p) => ProductModel.fromJson(p))
                  .toList(),
            );
          }
        }
        responseModel = ResponseModel(
            true, response.body['message'] ?? " fetchOrder success");

        log("orderList length ${orderList.length}");
        log("product length ${orderProductList.length}");
      } else {
        log("orderList length else ${orderList.length}");

        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while fetchOrder user");
      }
    } catch (e) {
      log('ERROR AT fetchOrder(): $e');
      responseModel = ResponseModel(false, "Error while fetchOrder user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  OrderModel? selectOrder;

  void updateSelectOrder(int? orderId) {
    selectOrder = orderList.firstWhere(
      (orderModel) => orderModel.id?.toString() == orderId?.toString(),
      orElse: () => OrderModel(),
    );

    update();
  }
}
