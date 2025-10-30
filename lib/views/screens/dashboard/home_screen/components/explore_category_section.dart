import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:lekra/controllers/home_controller.dart';
import 'package:lekra/data/models/home/category_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/category_screen/category_detaisl.dart';

class ExploreCategorySection extends StatelessWidget {
  const ExploreCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GetBuilder<HomeController>(builder: (homeController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Explore Categories",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 110,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: homeController.categoryList.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final category = homeController.isLoading
                    ? CategoryModel()
                    : homeController.categoryList[index];
                return _CategoryCard(category: category);
              },
            ),
          ),
        ],
      );
    });
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            navigate(
                context: context,
                page: CategoryDetailsScreen(
                  categoryModel: category,
                ));
          },
          child: CircleAvatar(
              radius: 32,
              backgroundColor: white,
              child: CustomImage(
                path: category.icon ?? "",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              )),
        ),
        const SizedBox(height: 8),
        Text(
          category.name ?? "",
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
