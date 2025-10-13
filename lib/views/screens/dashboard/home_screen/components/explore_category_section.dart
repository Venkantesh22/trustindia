import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lekra/generated/assets.dart';

class ExploreCategorySection extends StatelessWidget {
  const ExploreCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            itemCount: categoryList.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final category = categoryList[index];
              return _CategoryCard(category: category);
            },
          ),
        ),
      ],
    );
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
            // TODO: Navigate or perform category-specific action
          },
          child: CircleAvatar(
            radius: 32,
            backgroundColor: Colors.blue.withValues(alpha: 0.1),
            child: SvgPicture.asset(
              category.icon,
              width: 28,
              height: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          category.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class CategoryModel {
  final String title;
  final String icon;
  const CategoryModel({required this.title, required this.icon});
}

final List<CategoryModel> categoryList = [
  CategoryModel(title: "Medicines", icon: Assets.imagesCall),
  CategoryModel(title: "Electronics", icon: Assets.imagesCall),
  CategoryModel(title: "Fashion", icon: Assets.imagesCall),
];
