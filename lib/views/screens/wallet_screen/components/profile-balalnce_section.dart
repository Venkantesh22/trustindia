import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';

class ProfileBalanceSection extends StatelessWidget {
  const ProfileBalanceSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage(
              path: authController.userModel?.image ?? "",
              height: 120,
              width: 120,
              radius: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              capitalize(authController.userModel?.name),
              style:
                  Helper(context).textTheme.titleSmall?.copyWith(fontSize: 20),
            ),
            Text(
              PriceConverter.convertToNumberFormat(
                  authController.userModel?.currentWallet ?? 0.00),
              style: Helper(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: primaryColor, fontSize: 26),
            ),
            Text(
              "Current Balance",
              style: Helper(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: grey, fontSize: 14),
            )
          ],
        ),
      );
    });
  }
}
