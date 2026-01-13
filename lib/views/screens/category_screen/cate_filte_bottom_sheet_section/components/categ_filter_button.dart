import 'package:flutter/material.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/category_screen/components/category_filter_button.dart';

class CateFilterButton extends StatelessWidget {
  final CategoryFilterModel categoryFilterModel;
  final bool isSelected; // Add this
  const CateFilterButton({
    super.key,
    required this.categoryFilterModel,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? greyLight.withValues(alpha: 0.2) : white,
      ),
      child: Text(
        categoryFilterModel.title ?? "",
        style: Helper(context).textTheme.bodyLarge?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

List<CategoryFilterModel> cateButtonList = [
  CategoryFilterModel(filterId: CateFilterBarEnum.price, title: "Price")
];
