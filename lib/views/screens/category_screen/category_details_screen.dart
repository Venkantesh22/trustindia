import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/data/models/home/category_model.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/category_screen/components/product_card_category.dart';
import 'package:lekra/views/screens/product_details_screen/product_details_screen.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryDetailsScreen({super.key, required this.categoryModel});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductController>()
          .fetchCategory(categoryId: widget.categoryModel.id);
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final c = _scrollController;
    if (!c.hasClients) return;

    final productController = Get.find<ProductController>();
    final st = productController.cateProductListState;

    if (st.isMoreLoading || st.isInitialLoading) return; // already busy
    if (!st.canLoadMore) return;

    // more reliable than pixels/maxScrollExtent
    if (c.position.extentAfter < 400) {
      productController.fetchCategory(
        categoryId: widget.categoryModel.id, // <-- IMPORTANT
        loadMore: true,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: white,
      onRefresh: () async {
        final res = await Get.find<ProductController>()
            .fetchCategory(categoryId: widget.categoryModel.id, refresh: true);
        if (!res.isSuccess) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(res.message)),
          );
        }
      },
      child: Scaffold(
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
        body: GetBuilder<ProductController>(builder: (productController) {
          final isInitialLoading =
              productController.cateProductListState.isInitialLoading;
          final isMoreLoading =
              productController.cateProductListState.isMoreLoading;
          final items = productController.cateProductList;

          final showLoaderTile = isMoreLoading;

          final itemCount = isInitialLoading
              ? 4 // skeleton placeholders
              : items.length + (showLoaderTile ? 1 : 0);
          if (productController.cateProductList.isEmpty) {
            return const Center(
              child: Text("No Product available "),
            );
          }
          return SingleChildScrollView(
            controller: _scrollController,
            padding: AppConstants.screenPadding,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: productController.isLoading ? 4 : itemCount,
              itemBuilder: (context, index) {
                if (isInitialLoading) {
                  final productModel = ProductModel();
                  return CustomShimmer(
                    isLoading: true,
                    child: ProductCardForCategory(product: productModel),
                  );
                }
                if (showLoaderTile && index == items.length) {
                  final productModel = ProductModel();
                  return CustomShimmer(
                    isLoading: true,
                    child: ProductCardForCategory(product: productModel),
                  );
                }

                final product = productController.isLoading
                    ? ProductModel()
                    : productController.cateProductList[index];

                return CustomShimmer(
                  isLoading: productController.isLoading,
                  child: GestureDetector(
                    onTap: () {
                      if (productController.isLoading) {
                        return;
                      }
                      navigate(
                        context: context,
                        page: ProductDetailsScreen(
                          productId: product.id,
                        ),
                      );
                    },
                    child: ProductCardForCategory(product: product),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
