import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/dashboard/profile_screen/conponents/profile_row_title.dart';
import 'package:lekra/views/screens/widget/custom_back_button.dart';

class ProfileButton extends StatelessWidget {
  final bool isLoading;
  final String title;
  final Color color;
  final VoidCallback? onPressed; // nullable!
  const ProfileButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: color.withValues(alpha: 0.4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: white,
                ),
              )
            : Text(
                title,
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400, fontSize: 16, color: white),
              ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const CustomBackButton(),
                Text(
                  "My Profile",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            UserProfileContainer(),
            SizedBox(height: 35),
            Row(
              children: [
                CustomImage(
                  path: Assets.imagesEditProfileIcon,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16), 
              ],
            )
          ],
        ),
      ),
    );
  }
}
