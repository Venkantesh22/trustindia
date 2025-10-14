import 'package:flutter/material.dart';
import 'package:lekra/data/models/home/category_model.dart';
import 'package:lekra/services/theme.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryDetailsScreen({super.key, required this.categoryModel});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back_ios, color: black),
        title: Text(
          widget.categoryModel.name ?? "",
        ),
      ),
    );
  }
}
