import 'dart:developer';

import 'package:get/get.dart';
import 'package:lekra/data/models/home/banner_model';
import 'package:lekra/data/models/response/response_model.dart';
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
}
