import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/product_controller.dart';
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
              AddToCardButton(
                onTap: () {},
              ),
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





      // Container(
      //           padding: EdgeInsets.all(6),
      //           decoration: BoxDecoration(
      //             color: grey.withValues(alpha: 0.1),
      //             borderRadius: BorderRadius.circular(12),
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 10.0),
      //                 child: Text(
      //                   // category name is not part of ProductModel by default — pass separately if needed
      //                   capitalize("Category name") ?? "",
      //                   style: Helper(context).textTheme.titleSmall?.copyWith(
      //                       fontSize: 14, fontWeight: FontWeight.bold),
      //                 ),
      //               ),
      //               Row(
      //                 children: [
      //                   GestureDetector(
      //                     onTap: () {},
      //                     child: Container(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 4, vertical: 8),
      //                         decoration: BoxDecoration(
      //                             color: grey.withValues(alpha: 0.5),
      //                             borderRadius: BorderRadius.circular(16)),
      //                         child: const Icon(
      //                           Icons.remove,
      //                           size: 24,
      //                         )),
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.symmetric(horizontal: 6.0),
      //                     child: Text(
      //                       "999",
      //                       style: Helper(context)
      //                           .textTheme
      //                           .titleSmall
      //                           ?.copyWith(
      //                               fontSize: 18, fontWeight: FontWeight.bold),
      //                     ),
      //                   ),
      //                   GestureDetector(
      //                     onTap: () {},
      //                     child: Container(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 4, vertical: 8),
      //                         decoration: BoxDecoration(
      //                             color: primaryColor,
      //                             borderRadius: BorderRadius.circular(16)),
      //                         child: const Icon(
      //                           Icons.add,
      //                           size: 24,
      //                           color: white,
      //                         )),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),