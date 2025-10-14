import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/services/constants.dart';

class ProductDescSection extends StatelessWidget {
  const ProductDescSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.description, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text("Product Description",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              capitalize(productController.productModel?.description ?? "No description provided.") 
                  ,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    });
  }
}
