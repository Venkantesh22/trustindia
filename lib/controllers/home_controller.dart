import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/repositories/home_repo.dart';

class HomeController  extends  GetxController implements GetxService  {

  final HomeRepo homeRepo;
  HomeController({required this.homeRepo});
  bool _isLoading = false;


TextEditingController searchController = TextEditingController();


}