import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lekra/controllers/product_controller.dart';

class KeyFeaturesSection extends StatelessWidget {
  const KeyFeaturesSection({
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
                Icon(Icons.verified, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text("Key Features",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
                runSpacing: 8,
                spacing: 8,
                children: List.generate(
                  productController.isLoading
                      ? 4
                      : (productController.productModel?.features?.length ?? 0),
                  (index) => FeatureChip(
                      text: productController.productModel?.features?[index] ??
                          ""),
                )),
          ],
        ),
      );
    });
  }
}

class FeatureChip extends StatelessWidget {
  final String text;
  const FeatureChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text, style: Theme.of(context).textTheme.bodyMedium),
      backgroundColor: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}
