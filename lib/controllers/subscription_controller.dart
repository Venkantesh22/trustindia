import 'dart:developer';

import 'package:get/get.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/models/subscription_cate_model.dart';
import 'package:lekra/data/models/subscription_model.dart';
import 'package:lekra/data/repositories/subscription_repo.dart';

class SubscriptionController extends GetxController implements GetxService {
  final SubscriptionRepo subscriptionRepo;

  SubscriptionController({required this.subscriptionRepo});

  bool isLoading = false;

  List<SubscriptionCategoryModel> subscriptionCateList = [];
  Future<ResponseModel> fetchSubscriptionCatePlan() async {
    log('-----------  fetchSubscriptionCatePlan() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response =
          await subscriptionRepo.fetchSubscriptionCategoryPlan();

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is List) {
        subscriptionCateList = (response.body['data'] as List)
            .map((e) => SubscriptionCategoryModel.fromJson(e))
            .toList();

        log("subscriptionCateList length ${subscriptionCateList.length}");

        responseModel = ResponseModel(
            true, response.body['message'] ?? "fetchSubscriptionPlan");
      } else {
        log("subscriptionCateList length else ${subscriptionCateList.length}");
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Something Went Wrong fetchSubscriptionPlan");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchSubscriptionPlan");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  SubscriptionCategoryModel? selectSubscriptionCategoryModel;

  void updateSelectSubscriptionCategoryModel(SubscriptionCategoryModel value) {
    selectSubscriptionCategoryModel = value;
  }

  List<SubscriptionModel> subscriptionList = [];
  Future<ResponseModel> fetchSubscriptionPlanById() async {
    log('-----------  fetchSubscriptionPlanById() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await subscriptionRepo.fetchSubscriptionPlanById(
          id: selectSubscriptionCategoryModel?.id);

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is List) {
        subscriptionList = (response.body['data'] as List)
            .map((e) => SubscriptionModel.fromJson(e))
            .toList();

        log("subscriptionList length ${subscriptionList.length}");

        responseModel = ResponseModel(
            true, response.body['message'] ?? "fetchSubscriptionPlan");
      } else {
        log("subscriptionList length else ${subscriptionList.length}");
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Something Went Wrong fetchSubscriptionPlan");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchSubscriptionPlan");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  SubscriptionModel? selectSubscription;
  Future<ResponseModel> fetchSubscriptionPlanDetails({required int? id}) async {
    log('-----------  fetchSubscriptionPlanDetails() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response =
          await subscriptionRepo.fetchSubscriptionPlanDetails(id: id);

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is Map) {
        selectSubscription = SubscriptionModel.fromJson(response.body['data']);

        responseModel = ResponseModel(
            true, response.body['message'] ?? "fetchSubscriptionPlanDetails");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Something Went Wrong fetchSubscriptionPlanDetails");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchSubscriptionPlanDetails");
    }

    isLoading = false;
    update();
    return responseModel;
  }

// SubscriptionModel? selectSubscription;

  Future<ResponseModel> subscriptionCheckout({required int? id}) async {
    log('-----------  subscriptionCheckout() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await subscriptionRepo.subscriptionCheckout(id: id);

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is Map) {
        selectSubscription = SubscriptionModel.fromJson(response.body['data']);

        responseModel = ResponseModel(
            true, response.body['message'] ?? "subscriptionCheckout");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Something Went Wrong subscriptionCheckout");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "subscriptionCheckout");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
