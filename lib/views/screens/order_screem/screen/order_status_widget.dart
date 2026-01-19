import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/order_screem/screen/order_details_screen.dart';

class OrderStatusWidget extends StatelessWidget {
  final OrderDetailsScreen widget;

  const OrderStatusWidget({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: greyBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Status",
                  style: Helper(context).textTheme.titleLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 36),
                widget.productModel.orderStatus != null
                    ? CustomImage(
                        path: widget.productModel.orderStatus ?? "",
                        height: 83,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
              ],
            ),
          ],
        ),
      );
    });
  }
}
