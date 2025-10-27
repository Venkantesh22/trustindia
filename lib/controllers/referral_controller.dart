import 'dart:developer';

import 'package:get/get.dart';
import 'package:lekra/data/models/referral_model.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/models/reward_transaction_model.dart';
import 'package:lekra/data/models/scratch_model.dart';
import 'package:lekra/data/repositories/referral_repo.dart';

class ReferralController extends GetxController implements GetxService {
  final ReferralRepo referralRepo;
  ReferralController({required this.referralRepo});
  bool isLoading = false;

  List<ReferralModel> referralList = [];
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
          response.body['data']['referrals'] is List) {
        referralList = (response.body['data']['referrals'] as List)
            .map((item) => ReferralModel.fromJson(item))
            .toList();

        log("referralList list : ${referralList.length}");
        responseModel = ResponseModel(true, "Success fetch fetchReferral");
      } else {
        log("referralList list else : ${referralList.length}");

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

  List<ScratchCardModel> scratchCardList = [];
  Future<ResponseModel> fetchScratchCard() async {
    log('----------- fetchScratchCard Called() -------------');
    ResponseModel responseModel = ResponseModel(false, "Unknown error");
    isLoading = true;
    update();

    try {
      Response response = await referralRepo.fetchScratchCard();

      // ✅ Correct key is 'status'
      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data']['active_scratch_cards'] is List) {
        scratchCardList =
            (response.body['data']['active_scratch_cards'] as List)
                .map((item) => ScratchCardModel.fromJson(item))
                .toList();

        log("scratch_cards list : ${scratchCardList.length}");
        responseModel = ResponseModel(true, "Success fetch fetchScratchCard");
      } else {
        log("scratch_cards list else : ${scratchCardList.length}");

        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchScratchCard");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> postScratchCardRedeem({required int? scratchId}) async {
    log('----------- postScratchCardRedeem Called() -------------');
    ResponseModel responseModel = ResponseModel(false, "Unknown error");
    isLoading = true;
    update();

    try {
      Response response =
          await referralRepo.postScratchCardRedeem(scratchId: scratchId);

      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is Map) {
        responseModel =
            ResponseModel(true, "Success fetch postScratchCardRedeem");
        fetchScratchCard();
      } else {
        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "postScratchCardRedeem");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  List<RewardsTransactionModel> rewardTransactionList = [];
  bool isRewardHistoryLoading = false;

  Future<ResponseModel> fetchRewardsWallerHistory() async {
    log('----------- fetchRewardsWallerHistory Called() -------------');
    ResponseModel responseModel = ResponseModel(false, "Unknown error");
    isRewardHistoryLoading = true;
    update();

    try {
      Response response = await referralRepo.fetchRewardsWallerHistory();

      // ✅ Correct key is 'status'
      if (response.statusCode == 200 &&
          response.body['status'] == true &&
          response.body['data'] is List) {
        rewardTransactionList = (response.body['data'] as List)
            .map((item) => RewardsTransactionModel.fromJson(item))
            .toList();

        log("rewardTransactionList list : ${rewardTransactionList.length}");
        responseModel =
            ResponseModel(true, "Success fetch fetchRewardsWallerHistory");
      } else {
        log("rewardTransactionList list else : ${rewardTransactionList.length}");

        responseModel = ResponseModel(
          false,
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "fetchScratchCard");
    }

    isRewardHistoryLoading = false;
    update();
    return responseModel;
  }
}
