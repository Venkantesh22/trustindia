import 'package:flutter/material.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String cateName;
  const CategoryDetailsScreen({super.key, required this.cateName});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.cateName),),
      );
  }
}