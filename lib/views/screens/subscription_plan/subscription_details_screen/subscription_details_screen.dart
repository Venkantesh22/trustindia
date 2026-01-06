import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/subscription_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/seleck_payment/seleck_payment_screen/select_payment_screen.dart';
import 'package:lekra/views/screens/dashboard/account_screen/account_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class SubscriptionDetailsScreen extends StatefulWidget {
  final int? subscriptionId;
  const SubscriptionDetailsScreen({super.key, this.subscriptionId});

  @override
  State<SubscriptionDetailsScreen> createState() =>
      _SubscriptionDetailsScreenState();
}

class _SubscriptionDetailsScreenState extends State<SubscriptionDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SubscriptionController>()
          .fetchSubscriptionPlanDetails(id: widget.subscriptionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Plan Details"),
      body:
          GetBuilder<SubscriptionController>(builder: (subscriptionController) {
        if (subscriptionController.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: CustomShimmer(
            isLoading: subscriptionController.isLoading,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: greyBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subscriptionController.selectSubscription?.name ?? "",
                    style: Helper(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 36,
                        ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    "A smart start for saving on your favorite products",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                      subscriptionController.selectSubscription?.priceFormat ??
                          "",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: grey,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: grey,
                            decorationThickness: 2,
                          )),
                  Text(
                    "${subscriptionController.selectSubscription?.discountPriceFormat ?? ""}/month",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ProfileButton(
                      title: "Activate Plan",
                      onPressed: () {
                        navigate(
                            context: context,
                            page: SelectPaymentScreen(
                              isMemberShipPayment: true,
                              totalAmount: subscriptionController
                                      .selectSubscription
                                      ?.discountPriceFormat ??
                                  "",
                            ));
                      },
                      color: primaryColor),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Divider(
                      color: grey,
                    ),
                  ),
                  Text(
                    "Benefits You Get",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final featuresText = subscriptionController.isLoading
                          ? ""
                          : subscriptionController
                              .selectSubscription?.features?[index];
                      return CustomShimmer(
                        isLoading: subscriptionController.isLoading,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 10,
                                color: black,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  featuresText ?? "",
                                  textAlign: TextAlign.start,
                                  style: Helper(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 15,
                    ),
                    itemCount: subscriptionController.isLoading
                        ? 2
                        : (subscriptionController
                                .selectSubscription?.features?.length ??
                            0),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
