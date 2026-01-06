import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/address/screen/address_screen.dart';
import 'package:lekra/views/screens/auth_screens/login_screen.dart';
import 'package:lekra/views/screens/dashboard/account_screen/screen/privacy_center_screen.dart';
import 'package:lekra/views/screens/dashboard/account_screen/screen/terms_conditions_screen.dart';
import 'package:lekra/views/screens/rewards/screen/reward_history_screen/reward_history_screen.dart';
import 'package:lekra/views/screens/rewards/screen/rewards_screen/rewards_screen.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_category/subscription_category_screen.dart';

class RowOfAccount extends StatelessWidget {
  final RowOfAccountModel rowOfAccountModel;
  const RowOfAccount({
    super.key,
    required this.rowOfAccountModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: rowOfAccountModel.onTap != null
          ? () => rowOfAccountModel.onTap!(context)
          : null,
      child: Row(
        children: [
          CustomImage(
            path: rowOfAccountModel.icon,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rowOfAccountModel.title,
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                ),
                if (rowOfAccountModel.subTitle != null)
                  Text(
                    rowOfAccountModel.subTitle ?? "",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: greyAccountText,
                        ),
                  ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_sharp,
            color: greyAccountText,
          )
        ],
      ),
    );
  }
}

class RowOfAccountModel {
  final String title;
  final String? subTitle;
  final String icon;
  final Function(BuildContext context)? onTap;

  RowOfAccountModel(
      {required this.title,
      this.subTitle,
      required this.icon,
      required this.onTap});
}

List<RowOfAccountModel> rowOfAccountModelList = [
  RowOfAccountModel(
    title: "Saved Addresses",
    subTitle: "Manage your saved Address",
    icon: Assets.svgsAddresssAccount,
    onTap: (context) {
      navigate(context: context, page: const AddressScreen());
    },
  ),
  RowOfAccountModel(
    title: "Create a Seller Account",
    subTitle: "Create your seller account for app",
    icon: Assets.svgsPersonAccount,
    onTap: (context) {
      navigate(context: context, page: const RewardHistoryScreen());
    },
  ),
  RowOfAccountModel(
    title: "Rewards",
    subTitle: "Gain your exclusive rewards",
    icon: Assets.svgsReward,
    onTap: (context) {
      navigate(context: context, page: const RewardsScreen());
    },
  ),
  RowOfAccountModel(
    title: "Membership Subscription ",
    subTitle: "Apply for premium membership",
    icon: Assets.svgsMembershipSubscription,
    onTap: (context) {
      navigate(context: context, page: const SubscriptionCategoryPlan());
    },
  ),
  RowOfAccountModel(
    title: "Help & Support",
    icon: Assets.svgsHelpSupport,
    onTap: (context) {
      // navigate(context: context, page: SubscriptionCategoryPlan());
    },
  ),
  RowOfAccountModel(
    title: "Privacy Center",
    icon: Assets.svgsPrivacyCenter,
    onTap: (context) {
      navigate(context: context, page: const PrivacyCenterScreen());
    },
  ),
  RowOfAccountModel(
    title: "Terms And Conditions",
    icon: Assets.svgsTermsPolicies,
    onTap: (context) {
      navigate(context: context, page: const TermsAndConditionScreen());
    },
  ),
  RowOfAccountModel(
    title: "Log out",
    subTitle: "Further secure your account for safety",
    icon: Assets.svgsLogout,
    onTap: (context) {
      Get.find<AuthController>().logout().then((value) {
        if (value.isSuccess) {
          showToast(message: value.message, typeCheck: value.isSuccess);
          navigate(
              context: context, page: const LoginScreen(), isRemoveUntil: true);
        } else {
          showToast(message: value.message, typeCheck: value.isSuccess);
        }
      });
    },
  ),
];
