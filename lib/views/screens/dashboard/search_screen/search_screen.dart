import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lekra/controllers/home_controller.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/dashboard/search_screen/components/custom_search_textfeild.dart';
import 'package:lekra/views/screens/product_details_screen/product_details_screen.dart';
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
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: homeController.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : homeController.searchProductList.isEmpty
                        ? const Center(child: Text("No products found."))
                        : ListView.separated(
                            shrinkWrap: true,
                            itemCount: homeController.isLoading
                                ? 2
                                : homeController.searchProductList.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final product = homeController.isLoading
                                  ? ProductModel()
                                  : homeController.searchProductList[index];
                              return GestureDetector(
                                onTap: () {
                                  if (homeController.isLoading) {
                                    return;
                                  }
                                  navigate(
                                      context: context,
                                      page: ProductDetailsScreen(
                                          productId: product.id));
                                },
                                child: CustomShimmer(
                                    isLoading: homeController.isLoading,
                                    child: SearchProductContainer(
                                        product: product)),
                              );
                            },
                          ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class SearchProductContainer extends StatelessWidget {
  const SearchProductContainer({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(
            path: (product.images != null && product.images!.isNotEmpty)
                ? product.images?.first.url ?? ""
                : "",
            height: 110,
            width: 100,
            fit: BoxFit.cover,
            radius: 12,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(product.name ?? "Unnamed product"),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 6,
                ),
                Card(
                  color: greyBorder,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text(
                      capitalize(product.categoryName ?? "Unnamed product"),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Text(
                      PriceConverter.convertToNumberFormat(
                          product.price ?? 0.00),
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      PriceConverter.convertToNumberFormat(
                          product.discountedPrice ?? 0.00),
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
