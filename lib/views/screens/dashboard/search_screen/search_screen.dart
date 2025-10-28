import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lekra/controllers/home_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/screens/dashboard/search_screen/components/custom_search_textfeild.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Search Products"),
      body: GetBuilder<HomeController>(builder: (homeController) {
        return Padding(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              CustomSearchTextfeild(
                onChanged: (value) {
                  // Cancel the previous timer only if it exists
                  if (timer?.isActive ?? false) {
                    timer!.cancel();
                  }

                  // Start a new debounce timer
                  timer = Timer(const Duration(milliseconds: 500), () {
                    if (value.isNotEmpty) {
                      homeController.fetchSearchProduct(query: value);
                    }
                  });
                },
                hintText: "Search Products",
                controller: searchController,
              ),
            ],
          ),
        );
      }),
    );
  }
}
