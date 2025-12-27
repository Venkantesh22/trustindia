import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';

class UserProfileContainer extends StatelessWidget {
  const UserProfileContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                color: black.withValues(alpha: 0.06),
                spreadRadius: 0,
                blurRadius: 4,
              )
            ]),
        child: Row(
          children: [
            CircleAvatar(
              radius: 36.5,
              backgroundColor: white,
              child: CustomImage(
                  height: 64,
                  width: 64,
                  radius: 100,
                  path: authController.userModel?.image ?? ""),
            ),
            const SizedBox(width: 11),
            Column(
              children: [
                Text(
                  authController.userModel?.name ?? "",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700, fontSize: 14, color: white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  authController.userModel?.email ?? "",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400, fontSize: 12, color: white),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
