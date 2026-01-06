import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/input_decoration.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/base/image_picker_sheet.dart';
import 'package:lekra/views/screens/dashboard/account_screen/profile_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = Get.find<AuthController>();
      authController.fetchUserProfile();
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Edit Profile"),
      body: GetBuilder<AuthController>(builder: (authController) {
        if (authController.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                authController.profileImage == null
                    ? CustomImage(
                        isProfile: true,
                        path: authController.userModel?.image != null
                            ? authController.userModel?.image ?? ""
                            : "",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        radius: 100,
                        onTap: () async {
                          final file = await getImageBottomSheet(context);
                          if (file != null) {
                            authController.updateImages(file);
                          }
                        },
                      )
                    : InkWell(
                        onTap: () async {
                          final file = await getImageBottomSheet(context);
                          if (file != null) {
                            authController.updateImages(file);
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            authController.profileImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  authController.userModel?.email ?? "",
                  style: Helper(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomProfileTextfeild(
                        hint: "Enter your name",
                        title: "Name",
                        controller: authController.nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      CustomProfileTextfeild(
                        hint: "Enter your Mobile number",
                        title: "Mobile number",
                        controller: authController.numberController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "number is required";
                          }
                          if (value.length != 10) {
                            return "Please number should be 10 digit";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ProfileButton(
                          isLoading: authController.updateProfileLoading,
                          title: "Update",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await authController
                                  .updateProfile()
                                  .then((value) {
                                if (value.isSuccess) {
                                  showToast(
                                      message: value.message,
                                      typeCheck: value.isSuccess);
                                  pop(context);
                                } else {
                                  showToast(
                                      message: value.message,
                                      typeCheck: value.isSuccess);
                                }
                              });
                            }
                          },
                          color: primaryColor)
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class CustomProfileTextfeild extends StatelessWidget {
  final String title;
  final String hint;
  final bool enabled;
  final bool isAddress;
  final Function()? onTap;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const CustomProfileTextfeild(
      {super.key,
      required this.title,
      required this.hint,
      this.enabled = true,
      required this.controller,
      this.isAddress = false,
      required this.validator,
      this.suffixIcon,
      this.onTap,
      this.keyboardType,
      this.inputFormatters,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: onTap != null,
          onTap: onTap,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          controller: controller,
          maxLines: isAddress ? 3 : null,
          enabled: enabled,
          style: Helper(context).textTheme.bodyMedium,
          decoration: CustomDecoration.inputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            borderColor: greyDark,
            suffix: suffixIcon,
            hint: hint,
            hintStyle:
                Helper(context).textTheme.bodySmall?.copyWith(color: greyDark),
          ),
          validator: validator,
        )
      ],
    );
  }
}
