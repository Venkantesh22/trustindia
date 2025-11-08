import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/repositories/fund_request_repo.dart';

class FundRequestController extends GetxController implements GetxService {
  final FundRequestRepo fundRequestRepo;
  FundRequestController({required this.fundRequestRepo});

  final TextEditingController utrNoController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // --- Bank dropdown state ---
  final List<String> banks = <String>[
    'HDFC Bank',
    'ICICI Bank',
    'State Bank of India',
    'Axis Bank',
    'Yes Bank',
  ];
  String? selectedBank;

  void setBank(String? value) {
    selectedBank = value;
    update();
  }

  @override
  void onClose() {
    utrNoController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.onClose();
  }
}
