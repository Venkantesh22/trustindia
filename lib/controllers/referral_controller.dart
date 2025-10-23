import 'dart:developer';

import 'package:get/get.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/referral_repo.dart';

class ReferralController extends GetxController implements GetxService {
  final ReferralRepo referralRepo;
  ReferralController({required this.referralRepo});
  bool isLoading = false;

  Future<ResponseModel> fetchReferral() async {
    log('----------- fetchReferral Called() -------------');
    ResponseModel responseModel = ResponseModel(false, "Unknown error");
    isLoading = true;
    update();

    try {
      Response response = await referralRepo.fetchReferral();

      // ✅ Correct key is 'status'
      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data']['data'] is List) {
        // categoryList = (response.body['data']['data'] as List)
        //     .map((item) => CategoryModel.fromJson(item))
        //     .toList();

        // log("Category list : ${categoryList.length}");
        // log("First category created_at: ${categoryList.first.createdAt}");
        responseModel = ResponseModel(true, "Success fetch fetchReferral");
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchReferral");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
