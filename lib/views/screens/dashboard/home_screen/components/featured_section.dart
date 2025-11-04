import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lekra/controllers/home_controller.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/dashboard/home_screen/components/product_card.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      final isInitialLoading = homeController.featuredState.isInitialLoading;
      final isMoreLoading = homeController.featuredState.isMoreLoading;
      final items = homeController.featuredProductList;

      final showLoaderTile = isMoreLoading;

      final itemCount = isInitialLoading
          ? 4 // skeleton placeholders
          : items.length + (showLoaderTile ? 1 : 0);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "Featured Products",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (isInitialLoading) {
                final product = ProductModel();
                return CustomShimmer(
                  isLoading: true,
                  child: ProductCard(product: product, isLoading: true),
                );
              }

              // if this is the loader tile (last tile)
              if (showLoaderTile && index == items.length) {
                return const SizedBox(
                  height: 120,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              }

              final product = items[index];
              return GetBuilder<ProductController>(
                  builder: (productController) {
                return CustomShimmer(
                  isLoading: false,
                  child: ProductCard(product: product, isLoading: false),
                );
              });
            },
          ),
        ],
      );
    });
  }
}

// class FeaturedSection extends StatelessWidget {
//   const FeaturedSection({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(builder: (homeController) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           Text(
//             "Featured Products",
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 24,
//                 ),
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 10,
//               crossAxisSpacing: 10,
//               childAspectRatio: 0.7,
//             ),
//             itemCount: homeController.isLoading
//                 ? 4
//                 : homeController.featuredProductList.length,
//             itemBuilder: (context, index) {
//               final product = homeController.isLoading
//                   ? ProductModel()
//                   : homeController.featuredProductList[index];
//               return Builder(builder: (context) {
//                 return GetBuilder<ProductController>(
//                     builder: (productController) {
//                   return CustomShimmer(
//                     isLoading: homeController.isLoading,
//                     child: ProductCard(
//                       product: product,
//                       isLoading: homeController.isLoading,
//                     ),
//                   );
//                 });
//               });
//             },
//           ),
//         ],
//       );
//     });
//   }
// }
