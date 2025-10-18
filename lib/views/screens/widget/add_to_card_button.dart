import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class AddToCardButton extends StatelessWidget {
  final ProductModel product;

  const AddToCardButton({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      final bool isAdd = productController.cardModel?.products
              ?.any((p) => p.id == product.id) ??
          false;
      return GestureDetector(
        onTap: () {
          if (productController.isLoading) {
            showToast(
                message: "Please wait product adding to card",
                toastType: ToastType.info);
            return;
          }

          if (isAdd) {
            showToast(
                message: "Product also read add to card",
                toastType: ToastType.info);
          } else {
            productController.postAddToCard(product: product).then((value) {
              if (value.isSuccess) {
                showToast(message: value.message, typeCheck: value.isSuccess);
              } else {
                showToast(message: value.message, typeCheck: value.isSuccess);
              }
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: isAdd ? secondaryColor : primaryColor,
              borderRadius: BorderRadius.circular(12)),
          child: isAdd
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      color: white,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "In Card",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: white,
                          ),
                    )
                  ],
                )
              : Center(
                  child: Text(
                    "Add to Card",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: white,
                        ),
                  ),
                ),
        ),
      );
    });
  }
}
