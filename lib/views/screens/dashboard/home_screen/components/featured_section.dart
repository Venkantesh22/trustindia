import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lekra/controllers/home_controller.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/base/shimmer.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Featured Products",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
          ),
          const SizedBox(
            height: 12,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: homeController.isLoading
                ? 4
                : homeController.featuredProductList.length,
            itemBuilder: (context, index) {
              final product = homeController.isLoading
                  ? ProductModel()
                  : homeController.featuredProductList[index];
              String priceString = product.price ?? "0";
              return CustomShimmer(
                isLoading: homeController.isLoading,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: grey.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: CustomImage(
                          height: 120,
                          width: 120,
                          path: (product.images != null &&
                                  product.images!.isNotEmpty &&
                                  product.images![0].url != null &&
                                  product.images![0].url!.isNotEmpty)
                              ? product.images![0].url!
                              : "",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name ?? "",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            PriceConverter.convertToNumberFormat(
                                double.parse(priceString)),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                "Add to Card",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: white,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       product.name ?? "",
                      //       style:
                      //           Theme.of(context).textTheme.bodyLarge?.copyWith(
                      //                 fontWeight: FontWeight.w600,
                      //                 fontSize: 14,
                      //               ),
                      //     ),
                      //     const SizedBox(
                      //       height: 4,
                      //     ),
                      //     Text(
                      //       PriceConverter.convertToNumberFormat(
                      //           double.parse(priceString)),
                      //       style:
                      //           Theme.of(context).textTheme.bodyLarge?.copyWith(
                      //                 fontWeight: FontWeight.w600,
                      //                 fontSize: 14,
                      //               ),
                      //     ),
                      //     const SizedBox(
                      //       height: 4,
                      //     ),
                      //   ],
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(vertical: 8),
                      //   decoration: BoxDecoration(
                      //       color: primaryColor,
                      //       borderRadius: BorderRadius.circular(12)),
                      //   child: Center(
                      //     child: Text(
                      //       "Add to Card",
                      //       style:
                      //           Theme.of(context).textTheme.bodyLarge?.copyWith(
                      //                 fontWeight: FontWeight.w600,
                      //                 fontSize: 14,
                      //                 color: white,
                      //               ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
