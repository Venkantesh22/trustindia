
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/widget/add_to_card_button.dart';

class ProductCardForCategory extends StatelessWidget {
  const ProductCardForCategory({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Helper(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
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
                      product.price ?? 0.00),
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
                GetBuilder<ProductController>(
                    builder: (productController) {
                  return AddToCardButton(
                    product: product,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
