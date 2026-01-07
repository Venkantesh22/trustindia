
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/generated/assets.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class PremiumTopSection extends StatelessWidget {
  const PremiumTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Center(
        child: Column(
          children: [
            Text(
              authController.userModel?.subscription?.planName ?? "",
              style: Helper(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              "MEMBER TILL ${authController.userModel?.subscription?.endDateFormat}",
              style: Helper(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: yellow,
                  ),
            ),
            const SizedBox(height: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 9, vertical: 14),
              decoration: BoxDecoration(
                  color: black,
                  borderRadius: BorderRadius.circular(100),
                  border:
                      Border.all(color: yellow.withValues(alpha: 0.30))),
              child: Text(
                "${authController.userModel?.subscription?.remainingDays ?? ""}days remaining",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: secondaryColor,
                    ),
              ),
            ),
            const SizedBox(height: 16),
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
                    "SAVINGS TILL NOW",
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
            )
          ],
        ),
      );
    });
  }
}
