import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/state_manager.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/generated/assets.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/premium_screen/components/premium_benefit_container.dart';

class PremiumBottomSection extends StatelessWidget {
  const PremiumBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.svgsStar,
              height: 20,
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                "CURRENT BENEFITS",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: yellow,
                    ),
              ),
            ),
            SvgPicture.asset(
              Assets.svgsStar,
              height: 20,
              width: 20,
            ),
          ],
        ),
        const SizedBox(height: 16),
        const PremiumBenefitContainer(
            image: Assets.imagesGiftPremium,
            title: "Free delivery",
            desc:
                "Free delivery and high demand surge fee waiver on orders above ₹199,  May not be applicable at a few Location that manage their own delivery."),
        const SizedBox(
          height: 16,
        ),
        const PremiumBenefitContainer(
            image: Assets.imagesGrowPremium,
            title: "Priority support",
            desc:
                "24/7 priority customer support with dedicated assistance. Faster resolution times and exclusive access to premium support channels."),
        const SizedBox(
          height: 16,
        ),
        GetBuilder<AuthController>(builder: (authController) {
          return CustomButton(
            onTap: () {
//! ----- need to update   Get.find<SubscriptionController>()
//!          .subscriptionCheckout(
//!              id: Get.find<SubscriptionController>().selectSubscription?.id)

              // navigate(
              //     context: context,
              //     page: SelectPaymentScreen(
              //       isMemberShipPayment: true,
              //       totalAmount:
              //           authController.userModel?.subscription?.discountPrice ??
              //               "",
              //     ));
            },
            borderColor: secondaryColor,
            radius: 8,
            color: white,
            child: Text(
              "Renew Membership",
              style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: secondaryColor),
            ),
          );
        }),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(),
        ),
        Text(
          "Membership benefits are subject to terms and conditions For assistance, contact our support team",
          textAlign: TextAlign.center,
          style: Helper(context).textTheme.bodyLarge?.copyWith(
                fontSize: 12,
                height: 2.4,
                fontWeight: FontWeight.w400,
                color: greyLight,
              ),
        )
      ],
    );
  }
}
