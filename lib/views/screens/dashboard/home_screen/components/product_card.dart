import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/product_details_screen/product_details_screen.dart';
import 'package:lekra/views/screens/widget/add_to_card_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isLoading,
  });

  final ProductModel product;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLoading) {
          return;
        }
        navigate(
            context: context,
            page: ProductDetailsScreen(
              productId: product.id,
            ));
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                    radius: 12,
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
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      product.discountedPriceFormat,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: primaryColor,
                          ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    GetBuilder<ProductController>(builder: (productController) {
                      return AddToCardButton(
                        product: product,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              top: 10,
              right: 10,
              child: product.offers != null &&
                      (product.offers?.isNotEmpty ?? false)
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                          color: red, borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        product.offersFormat,
                        style: Helper(context).textTheme.bodySmall?.copyWith(
                            color: white, fontWeight: FontWeight.w500),
                      ),
                    )
                  : const SizedBox())
        ],
      ),
    );
  }
}
