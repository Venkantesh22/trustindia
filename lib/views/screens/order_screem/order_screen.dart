import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/checkout_controlller.dart';
import 'package:lekra/data/models/order_model.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/widget/custom_appbar2.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CheckoutController>().fetchOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Order"),
      body: Padding(
        padding: AppConstants.screenPadding,
        child: GetBuilder<CheckoutController>(builder: (checkoutController) {
          return Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final product = checkoutController.isLoading
                      ? ProductModel()
                      : checkoutController.orderProductList[index];
                  return OrderContainer(productModel: product);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                itemCount: checkoutController.isLoading
                    ? 2
                    : checkoutController.orderProductList.length,
              )
            ],
          );
        }),
      ),
    );
  }
}

class OrderContainer extends StatelessWidget {
  final ProductModel productModel;
  const OrderContainer({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: black.withValues(alpha: 0.2),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomImage(
            // path: productModel.images?[0].url ?? "",
            path: Assets.imagesBanner1,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            radius: 12,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.name ?? "",
                  style: Helper(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Qty: ${productModel.quantity ?? ""}",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: grey.withValues(alpha: 10),
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Order ID: #${productModel.orderId ?? ""} ",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: grey.withValues(alpha: 10),
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "15 Oct 2026, 10:30AM",
                      style: Helper(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: green.withValues(alpha: 0.1)),
                      child: Text(
                        productModel.status ?? "",
                        style: Helper(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: green.withValues(alpha: 10),
                            ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
