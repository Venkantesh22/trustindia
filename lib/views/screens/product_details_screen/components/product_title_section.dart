import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/shimmer.dart';

class ProdTitleSection extends StatelessWidget {
  const ProdTitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return CustomShimmer(
        isLoading: productController.isLoading,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurRadius: 6,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                    color: black.withValues(alpha: 0.1)),
              ]),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              capitalize(productController.productModel?.name ?? ""),
              style: Helper(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
            ),
            const SizedBox(height: 8),
            productController.productModel?.discountedPrice != null
                ? Row(
                    children: [
                      Text(
                        productController.productModel?.priceFormat ?? "",
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        productController.productModel?.discountedPriceFormat ??
                            "",
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 20,
                            ),
                      ),
                    ],
                  )
                : Text(
                    productController.productModel?.priceFormat ?? "",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontSize: 20,
                        ),
                  ),
          ]),
        ),
      );
    });
  }
}
