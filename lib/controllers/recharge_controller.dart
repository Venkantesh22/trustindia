import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/service/network_service_model.dart';
import 'package:lekra/data/repositories/recharge_repo.dart';

class RechargeController extends GetxController implements GetxService {
  final RechargeRepo rechargeRepo;

  RechargeController({required this.rechargeRepo});

  bool isLoading = false;
  TextEditingController mobileController = TextEditingController();

  NetworkServiceModel? selectNetworkOperate;

  List<NetworkServiceModel> networkServiceModelList = [
    NetworkServiceModel(networkName: "AirTel", operatorId: "1"),
    NetworkServiceModel(networkName: "BSNL", operatorId: "2"),
    NetworkServiceModel(networkName: "Jio", operatorId: "167"),
    NetworkServiceModel(networkName: "Vodafone", operatorId: "5"),
  ];
}
