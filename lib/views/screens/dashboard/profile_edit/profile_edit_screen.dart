import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/views/screens/dashboard/profile_edit/components/profile_edit_from_section.dart';
import 'package:lekra/views/screens/dashboard/profile_edit/components/profile_edit_top_section.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController) {
        if (authController.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [EditProfileTopSection(), ProfileEditFormSection()],
          ),
        );
      }),
    );
  }
}

// class CustomProfileTextfeild extends StatelessWidget {
//   final String title;
//   final String hint;
//   final bool enabled;
//   final bool isAddress;
//   final Function()? onTap;
//   final TextEditingController controller;
//   final TextInputType? keyboardType;
//   final List<TextInputFormatter>? inputFormatters;
//   final Function(String)? onChanged;
//   final Widget? suffixIcon;
//   final FormFieldValidator<String>? validator;

//   const CustomProfileTextfeild(
//       {super.key,
//       required this.title,
//       required this.hint,
//       this.enabled = true,
//       required this.controller,
//       this.isAddress = false,
//       required this.validator,
//       this.suffixIcon,
//       this.onTap,
//       this.keyboardType,
//       this.inputFormatters,
//       this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: Helper(context).textTheme.bodyMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           readOnly: onTap != null,
//           onTap: onTap,
//           keyboardType: keyboardType,
//           inputFormatters: inputFormatters,
//           onChanged: onChanged,
//           controller: controller,
//           maxLines: isAddress ? 3 : null,
//           enabled: enabled,
//           style: Helper(context).textTheme.bodyMedium,
//           decoration: CustomDecoration.inputDecoration(
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//             borderColor: greyDark,
//             suffix: suffixIcon,
//             hint: hint,
//             hintStyle:
//                 Helper(context).textTheme.bodySmall?.copyWith(color: greyDark),
//           ),
//           validator: validator,
//         )
//       ],
//     );
//   }
// }
