import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/dashboard/profile_screen/profile_screen.dart';
import 'package:lekra/views/screens/checkout_screen/components/billing_form_section.dart';
import 'package:lekra/views/screens/checkout_screen/components/grand_total_section.dart';
import 'package:lekra/views/screens/dashboard/dashboard_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Checkout"),
      body: GetBuilder<OrderController>(builder: (checkoutController) {
        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppConstants.screenPadding,
                    child: GetBuilder<OrderController>(
                        builder: (checkoutController) {
                      return Column(
                        children: [
                          const GrandTotalSection(),
                          const SizedBox(
                            height: 20,
                          ),
                          BillingFormSection(formKey: _formKey),
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
                                    addressId:
                                        basicController.selectAddress?.id)
                                .then((value) {
                              if (value.isSuccess) {
                                Get.find<OrderController>()
                                    .postPayOrderWallet(
                                        orderId: Get.find<OrderController>()
                                            .orderId)
                                    .then((value) {
                                  if (value.isSuccess) {
                                    showToast(
                                        message: value.message,
                                        typeCheck: value.isSuccess);
                                    navigate(
                                        context: context,
                                        page: const DashboardScreen()); 
                                  } else {
                                    showToast(
                                        message: value.message,
                                        typeCheck: value.isSuccess);
                                  }
                                });
                              } else {
                                showToast(
                                    message: value.message,
                                    typeCheck: value.isSuccess);
                              }
                            });
                          }
                        },
                        color: secondaryColor),
                  );
                }),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
            if (checkoutController.isLoading)
              Positioned.fill(
                child: Container(
                  color: black.withValues(alpha: 0.4),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
