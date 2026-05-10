import 'package:flutter/material.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/lanch_helper.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';

class HelpNumberAndEmailWidget extends StatelessWidget {
  final HelpNumberAndEmailWidgetModel helpNumberAndEmailWidgetModel;
  const HelpNumberAndEmailWidget({
    super.key,
    required this.helpNumberAndEmailWidgetModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: helpNumberAndEmailWidgetModel.ontap,
        child: Container(
          decoration: BoxDecoration(
            color: greyLight.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImage(
                  path: helpNumberAndEmailWidgetModel.icon,
                  height: 56,
                  width: 56,
                  fit: BoxFit.cover,
                ),
                sizedBoxHeight(height: 24),
                Text(
                  helpNumberAndEmailWidgetModel.title,
                  style: Helper(context).textTheme.displaySmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: greyText2,
                        letterSpacing: 1.2,
                      ),
                ),
                sizedBoxHeight(height: 4),
                Text(
                  "+91 ${helpNumberAndEmailWidgetModel.subTitle}",
                  style: Helper(context).textTheme.displaySmall?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: blackText,
                      ),
                ),
              ],
            ),
          ),
        ));
  }
}

class HelpNumberAndEmailWidgetModel {
  final String title;
  final String icon;
  final String subTitle;
  final Function()? ontap;

  HelpNumberAndEmailWidgetModel(
      {required this.title,
      required this.icon,
      required this.subTitle,
      required this.ontap});
}

List<HelpNumberAndEmailWidgetModel> helpNumberAndEmailWidgetModelList(
        BasicController basicController) =>
    [
      HelpNumberAndEmailWidgetModel(
          title: "MABILE",
          icon: Assets.imagesHelpCall,
          subTitle: basicController.supportModel?.mobile ?? "",
          ontap: () {
            LaunchHelper.callUs(
                number: basicController.supportModel?.mobile ?? "");
          }),
      HelpNumberAndEmailWidgetModel(
          title: "WHATSAPP",
          icon: Assets.imagesHelpMessage,
          subTitle: basicController.supportModel?.whatsapp ?? "",
          ontap: () {
            LaunchHelper.launchWhatsApp(
                phone: basicController.supportModel?.whatsapp ?? "");
          }),
      HelpNumberAndEmailWidgetModel(
          title: "EMAIL SUPPORT",
          icon: Assets.imagesHelpEmail,
          subTitle: basicController.supportModel?.email ?? "",
          ontap: () {
            LaunchHelper.emailUs(
                email: basicController.supportModel?.email ?? "");
          }),
    ];
