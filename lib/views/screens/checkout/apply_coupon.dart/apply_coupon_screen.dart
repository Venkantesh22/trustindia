import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/coupon_controller.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/checkout/checkout_screen/checkout_screen.dart';
import 'package:lekra/views/screens/dashboard/profile_screen/profile_screen.dart';
import 'package:lekra/views/screens/widget/custom_back_button.dart';

class ApplyCouponScreen extends StatefulWidget {
  const ApplyCouponScreen({super.key});

  @override
  State<ApplyCouponScreen> createState() => _ApplyCouponScreenState();
}

class _ApplyCouponScreenState extends State<ApplyCouponScreen> {
  bool isFocused = false;
  bool showBottomBack = false;

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
      bottomNavigationBar: AnimatedSlide(
        offset: showBottomBack ? const Offset(0, 0) : const Offset(0, 1),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: showBottomBack ? 1 : 0,
          child: showBottomBack
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
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Coupon does not exist",
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: black,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: ProfileButton(
                          color: secondaryColor,
                          title: "Back",
                          onPressed: () => pop(context),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
      body: GetBuilder<CouponController>(builder: (couponController) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Focus(
                  onFocusChange: (focus) {
                    setState(() {
                      isFocused = focus;
                    });
                  },
                  child: Padding(
                    padding: AppConstants.screenPadding,
                    child: TextFormField(
                      controller: couponController.couponCodeController,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        label: Text(
                          "Enter coupon code",
                          style: Helper(context).textTheme.bodyMedium?.copyWith(
                                color: isFocused ? secondaryColor : greyDark,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        suffix: GestureDetector(
                          onTap: () {
                            if (couponController
                                .couponCodeController.text.isNotEmpty) {
                              couponController
                                  .validateCouponController()
                                  .then((value) {
                                if (value.isSuccess) {
                                  navigate(
                                      context: context,
                                      page: const CheckoutScreen(
                                        showDialogOfDiscount: true,
                                      ));
                                } else {
                                  setState(() {
                                    showBottomBack = true;
                                  });
                                  showToast(
                                    message: value.message,
                                    typeCheck: value.isSuccess,
                                  );
                                }
                              });
                            }
                          },
                          child: Text(
                            "APPLY",
                            style:
                                Helper(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: isFocused ||
                                              couponController
                                                  .couponCodeController
                                                  .text
                                                  .isNotEmpty
                                          ? secondaryColor
                                          : greyDark,
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
                          borderSide:
                              BorderSide(color: secondaryColor, width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: red, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // ✅ Full-screen loading overlay
            if (couponController.isLoading ||
                Get.find<ProductController>().isLoading)
              Container(
                color: black.withValues(alpha: 0.4),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      }),
    );
  }
}
