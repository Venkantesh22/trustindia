import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/base/dialogs/logout_dialog.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Profile", showBackButton: false,),
      body: Center(
        child: GetBuilder<AuthController>(builder: (authController) {
          return Padding(
            padding: AppConstants.screenPadding,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "My Profile",
                    style: Helper(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        CustomImage(
                          path: authController.userModel?.image ?? "",
                          width: 96,
                          height: 96,
                          radius: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          authController.userModel?.name ?? "",
                          style: Helper(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          authController.userModel?.email ?? "",
                          style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ProfileButton(
                          title: "Edit Profile",
                          onPressed: () {},
                          color: primaryColor,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ProfileButton(
                          title: "Logout",
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => const LogoutDialog());
                          },
                          color: secondaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function() onPressed;
  const ProfileButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        title,
        style: Helper(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold, color: white),
      ),
    );
  }
}
