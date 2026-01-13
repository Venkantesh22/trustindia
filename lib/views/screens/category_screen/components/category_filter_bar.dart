import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/views/screens/category_screen/components/category_filter_button.dart';

class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return SizedBox(
          height: 35,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final categoryFilterModel = categoryFilterList[index];
                return CategoryFilterButton(
                  categoryFilterModel: categoryFilterModel,
                  onTap: () {
                    productController
                        .updateCateFilterBarEnum(categoryFilterModel.filterId);
                  },
                  isSelected: categoryFilterModel.filterId ==
                      productController.selectCateFilterBar,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: categoryFilterList.length));
    });
  }
}
