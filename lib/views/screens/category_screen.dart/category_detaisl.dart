import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/data/models/home/category_model.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/product_details_screen/product_details_screen.dart';
import 'package:lekra/views/screens/widget/add_to_card_button.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryDetailsScreen({super.key, required this.categoryModel});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductController>()
        .fetchCategory(categoryId: widget.categoryModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: black)),
        centerTitle: true,
        title: Text(
          capitalize(widget.categoryModel.name ?? ""),
          style: Helper(context).textTheme.titleMedium?.copyWith(
                color: black,
                fontSize: 22,
              ),
        ),
      ),
      body: GetBuilder<ProductController>(builder: (categoryController) {
        if (categoryController.cateProductList.isEmpty) {
          return const Center(
            child: Text("No Product available "),
          );
        }
        return Padding(
          padding: AppConstants.screenPadding,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            itemCount: categoryController.isLoading
                ? 4
                : categoryController.cateProductList.length,
            itemBuilder: (context, index) {
              final product = categoryController.isLoading
                  ? ProductModel()
                  : categoryController.cateProductList[index];

              return CustomShimmer(
                isLoading: categoryController.isLoading,
                child: GestureDetector(
                  onTap: () {
                    if (categoryController.isLoading) {
                      return;
                    }
                    navigate(
                      context: context,
                      page: ProductDetailsScreen(
                        productId: product.id,
                      ),
                    );
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: const Offset(0, 4),
                              color: black.withValues(alpha: 0.1))
                        ],
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImage(
                          path: product.images?[0].url ?? "",
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsetsGeometry.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                capitalize(product.name ?? ""),
                                style: Helper(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: black,
                                        fontWeight: FontWeight.bold),
                              ),
                              Text(
                                product.description ?? "Loading...",
                                style: Helper(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: grey,
                                    ),
                                maxLines: 1,
                              ),
                              Text(
                                PriceConverter.convertToNumberFormat(
                                    double.parse(product.price ?? "0")),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              AddToCardButton(
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
