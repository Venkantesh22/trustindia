import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/screens/product_details_screen/components/key_featured_section.dart';
import 'package:lekra/views/screens/product_details_screen/components/image_section.dart';
import 'package:lekra/views/screens/product_details_screen/components/product_descr_section.dart';
import 'package:lekra/views/screens/product_details_screen/components/product_title_section.dart';
import 'package:lekra/views/screens/widget/add_to_card_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int? productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductController>().fetchProduct(productId: widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProductImageSection(),
              const ProdTitleSection(),
              const SizedBox(
                height: 12,
              ),
              GetBuilder<ProductController>(builder: (productController) {
                return AddToCardButton(
                  product: productController.productModel ?? ProductModel(),
                  // isAdd: productController.cardModel?.products
                  //         ?.any((product) => product.id == widget.productId) ??
                  //     false,
                
                );
              }),
              const SizedBox(height: 16),
              const KeyFeaturesSection(),
              const SizedBox(height: 18),
              const ProductDescSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}





      