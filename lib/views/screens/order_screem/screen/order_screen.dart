import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/data/models/product_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/order_screem/components/order_container.dart';
import 'package:lekra/views/screens/order_screem/screen/order_details_screen.dart';

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
      Get.find<OrderController>().fetchOrder();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
       
        title: Text(
          "Order",
          style: Helper(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: GetBuilder<OrderController>(builder: (orderController) {
          if (orderController.orderProductList.isEmpty) {
            return const Center(child: Text("No Order"));
          }
          return Column(
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final product = orderController.isLoading
                      ? ProductModel()
                      : orderController.orderProductList[index];
                  return CustomShimmer(
                    isLoading: orderController.isLoading,
                    child: GestureDetector(
                        onTap: () {
                          if (orderController.isLoading) {
                            showToast(
                                message: "Please waiting...",
                                toastType: ToastType.info);
                            return;
                          }
                          orderController.updateSelectOrder(product.orderId);
                          navigate(
                              context: context,
                              page: OrderDetailsScreen(
                                productModel: product,
                              ));
                        },
                        child: OrderContainer(productModel: product)),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                itemCount: orderController.isLoading
                    ? 2
                    : orderController.orderProductList.length,
              )
            ],
          );
        }),
      ),
    );
  }
}
