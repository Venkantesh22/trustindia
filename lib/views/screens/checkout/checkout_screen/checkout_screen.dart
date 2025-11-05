import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/controllers/coupon_controller.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/controllers/product_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/checkout/checkout_screen/components/apply_coupon_container.dart';
import 'package:lekra/views/screens/checkout/checkout_screen/components/billing_form_section.dart';
import 'package:lekra/views/screens/checkout/checkout_screen/components/row_billing_text.dart';
import 'package:lekra/views/screens/checkout/pop_coupon/pop_coupon_container.dart';
import 'package:lekra/views/screens/seleck_payment/seleck_payment_screen/select_payment_screen.dart';

import 'package:lekra/views/screens/dashboard/profile_screen/profile_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class CheckoutScreen extends StatefulWidget {
  final bool showDialogOfDiscount;

  const CheckoutScreen({
    super.key,
    this.showDialogOfDiscount = false,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BasicController>().fetchAddress();
      if (widget.showDialogOfDiscount) {
        showDialog(
            context: context,
            builder: (context) {
              return const Dialog(
                child: PopCouponContainer(),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Checkout"),
      body: GetBuilder<OrderController>(builder: (orderController) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: AppConstants.screenPadding,
                child: GetBuilder<OrderController>(builder: (orderController) {
                  return Column(
                    children: [
                      BillingFormSection(formKey: _formKey),
                      const SizedBox(
                        height: 20,
                      ),
                      const ApplyCouponContainer(),
                      GetBuilder<ProductController>(
                          builder: (productController) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 28),
                              child: Text(
                                "Billing Summary",
                                style: Helper(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                            RowBillingText(
                              label: "Subtotal",
                              price:
                                  productController.cardModel?.subtotalFormat ??
                                      "",
                            ),
                            RowBillingText(
                              label: "Discount",
                              price:
                                  productController.cardModel?.discountFormat ??
                                      "",
                            ),
                            productController.cardModel?.couponDiscount !=
                                    "0.00"
                                ? RowBillingText(
                                    label:
                                        "Coupon Discount  ${productController.cardModel?.couponValue}",
                                    price: productController
                                            .cardModel?.couponDiscountFormat ??
                                        "",
                                  )
                                : const SizedBox(),
                            const Divider(
                              color: grey,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Grand Total",
                                  style: Helper(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                Text(
                                  productController
                                          .cardModel?.totalPriceFormat ??
                                      "",
                                  style: Helper(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        );
                      })
                    ],
                  );
                }),
              ),
            ),
            GetBuilder<BasicController>(builder: (basicController) {
              return Padding(
                padding: AppConstants.screenPadding,
                child: ProfileButton(
                    title: "Proceed to pay",
                    onPressed: () {
                      if (basicController.selectAddress == null) {
                        showToast(
                            message: "Select a address",
                            toastType: ToastType.info);
                        return;
                      }
                      if (_formKey.currentState?.validate() ?? false) {
                        Get.find<OrderController>()
                            .postCheckout(
                                addressId: Get.find<BasicController>()
                                    .selectAddress
                                    ?.id,
                                code: Get.find<CouponController>().couponCode)
                            .then(
                          (value) {
                            if (value.isSuccess) {
                              navigate(
                                  context: context,
                                  page: SelectPaymentScreen(
                                    totalAmount: Get.find<ProductController>()
                                            .cardModel
                                            ?.totalPriceFormat ??
                                        "",
                                  ));
                            } else {
                              showToast(
                                  message: value.message,
                                  typeCheck: value.isSuccess);
                            }
                          },
                        );
                      }
                    },
                    color: secondaryColor),
              );
            }),
            const SizedBox(
              height: 20,
            )
          ],
        );
      }),
    );
  }
}
