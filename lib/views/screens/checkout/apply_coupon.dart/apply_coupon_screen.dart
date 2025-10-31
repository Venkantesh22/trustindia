import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/dashboard/profile_screen/profile_screen.dart';
import 'package:lekra/views/screens/widget/custom_back_button.dart';

class ApplyCouponScreen extends StatefulWidget {
  const ApplyCouponScreen({super.key});

  @override
  State<ApplyCouponScreen> createState() => _ApplyCouponScreenState();
}

class _ApplyCouponScreenState extends State<ApplyCouponScreen> {
  final TextEditingController couponCodeController = TextEditingController();
  bool isFocused = false;
  bool showBottomBack = false;

  @override
  void dispose() {
    couponCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("APPLY COUPON", style: Helper(context).textTheme.bodyLarge),
            GetBuilder<ProductController>(builder: (productController) {
              return CustomShimmer(
                isLoading: productController.isLoading,
                child: Text(
                  "Your Cart ${productController.cardModel?.totalPriceFormat ?? ""}",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: greyBillText,
                      ),
                ),
              );
            }),
          ],
        ),
        leading: const CustomBackButton(),
      ),
      bottomNavigationBar: showBottomBack
          ? Container(
              padding: const EdgeInsets.only(top: 40, bottom: 26),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: black.withValues(alpha: 0.4),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: black.withValues(alpha: 0.4),
                      offset: const Offset(0, -2),
                      blurRadius: 4,
                      spreadRadius: 0,
                      blurStyle: BlurStyle.inner,
                    ),
                  ],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(40),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Coupon does not exist",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: black),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ProfileButton(
                      color: secondaryColor,
                      title: "Back",
                      onPressed: () => pop(context),
                    ),
                  )
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Focus(
          onFocusChange: (focus) {
            setState(() {
              isFocused = focus;
            });
          },
          child: TextFormField(
            controller: couponCodeController,
            decoration: InputDecoration(
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              label: Text(
                "Enter coupon code",
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      color: isFocused ? secondaryColor : greyDark,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              suffix: GestureDetector(
                onTap: () {
                  final code = couponCodeController.text.trim();
                  if (code.isEmpty) {}
                  // TODO: Apply coupon logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Applying coupon: $code")),
                  );
                },
                child: Text(
                  "APPLY",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isFocused ? secondaryColor : greyDark,
                      ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: secondaryColor, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: red, width: 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
