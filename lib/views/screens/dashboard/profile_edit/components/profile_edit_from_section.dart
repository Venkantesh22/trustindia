// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/date_formatters_and_converters.dart';
import 'package:lekra/services/extensions.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/base/custom_dropdown.dart';
import 'package:lekra/views/screens/widget/text_box/app_text_box.dart';

class ProfileEditFormSection extends StatefulWidget {
  const ProfileEditFormSection({
    super.key,
  });

  @override
  State<ProfileEditFormSection> createState() => _ProfileEditFormSectionState();
}

class _ProfileEditFormSectionState extends State<ProfileEditFormSection> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Edit Profile",
              style: Helper(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
            ),
            const SizedBox(height: 16),
            AppTextFieldWithHeading(
              controller: authController.firstNameController,
              hindText: "Enter a first name",
              heading: "First Name",
              bgColor: white,
              borderColor: black,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter first name";
                }
                return null;
              },
            ),
            const SizedBox(height: 9),
            AppTextFieldWithHeading(
              controller: authController.lastNameController,
              hindText: "Enter a Last name",
              heading: "Last Name",
              bgColor: white,
              borderColor: black,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter last name";
                }
                return null;
              },
            ),
            const SizedBox(height: 9),
            AppTextFieldWithHeading(
              controller: authController.emailController,
              hindText: "Enter a email",
              heading: "Email",
              bgColor: white,
              borderColor: black,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter email";
                }
                if (!value.isEmail) {
                  return "Please enter valid email";
                }
                return null;
              },
            ),
            const SizedBox(height: 9),
            AppTextFieldWithHeading(
              controller: authController.birthdayCodeController,
              hindText: "dd-mm-yyyy",
              hintStyle: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: greyBillText),
              heading: "Date of Birth",
              bgColor: white,
              borderColor: black,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: getDateTime(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: primaryColor,
                          onPrimary: white,
                          onSurface: black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (pickedDate != null) {
                  String formattedDate =
                      "${pickedDate.day.toString().padLeft(2, '0')}-"
                      "${pickedDate.month.toString().padLeft(2, '0')}-"
                      "${pickedDate.year}";

                  authController.birthdayCodeController.text = formattedDate;
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select date of birth";
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            CustomDropDownList<String>(
              value: authController.gender,
              items: authController.genderList,
              hintText: "Gender",
              hintStyle: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: greyBillText),
              bgColor: white,
              borderColor: black,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select gender';
                }
                return null;
              },
              onChanged: (v) async {
                authController.setGender(value: v ?? "");
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CustomButton(
                isLoading: authController.isLoading,
                onTap: () {
                  authController.updateProfile().then((value) {
                    if (value.isSuccess) {
                      pop(context);
                      showToast(
                          message: value.message, typeCheck: value.isSuccess);
                    } else {
                      showToast(
                          message: value.message, typeCheck: value.isSuccess);
                    }
                  });
                },
                radius: 100,
                child: Text(
                  "Update Profile",
                  style: Helper(context).textTheme.bodyLarge?.copyWith(
                        color: white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
            AppTextFieldWithHeading(
              controller: authController.numberController,
              hindText: "Enter a phone number",
              heading: "Phone Number",
              bgColor: white,
              borderColor: black,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter phone number";
                }
                if (value.length != 10) {
                  return "Please enter valid phone number";
                }
                return null;
              },
            ),
          ],
        ),
      );
    });
  }
}
