import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/repositories/recharge_repo.dart';

class RechargeController extends GetxController implements GetxService {
  final RechargeRepo rechargeRepo;

  RechargeController({required this.rechargeRepo});

  bool isLoading = false;
  TextEditingController mobileController = TextEditingController();
}
