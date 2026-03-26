import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/permission_controller.dart';
import 'package:lekra/controllers/recharge_controller.dart';
import 'package:lekra/data/models/service/mobile_recharge_service_models/recharge_state_area_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/base/custom_dropdown.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/pay_section/mobile_recharge/contact_list/contact_list_screen.dart';
import 'package:lekra/views/pay_section/mobile_recharge/mobile_recharge_select_no/mobile_recharge_select_option_wallet_dynamic/mobile_recharge_select_opions_wallet_dynamci_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';
import 'package:lekra/views/screens/widget/text_box/app_text_box.dart';

class MobileRechargeSelectNoScreen extends StatefulWidget {
  const MobileRechargeSelectNoScreen({super.key});

  @override
  State<MobileRechargeSelectNoScreen> createState() =>
      _MobileRechargeSelectNoScreenState();
}

class _MobileRechargeSelectNoScreenState
    extends State<MobileRechargeSelectNoScreen> {
  final _formKey = GlobalKey<FormState>();

  void mobileRecharge(RechargeController rechargeController) async {
    final permCtrl = Get.find<PermissionController>();
    final granted = await permCtrl.askWithDialogIfPermanentlyDenied();
    if (!granted) return;

    final selectedNumber = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const ContactsListScreen()),
    );

    if (selectedNumber != null && selectedNumber.isNotEmpty) {
      String clean = selectedNumber.replaceAll(RegExp(r'[^0-9]'), '');

      if (clean.length > 10) {
        clean = clean.substring(clean.length - 10);
      }

      rechargeController.mobileNoController.text = clean;

      if (clean.length == 10) {
        // _triggerRechargeAPIs(clean, rechargeController);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: "Mobile Recharge",
        centerTitle: false,
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: AppConstants.screenPadding,
              child:
                  GetBuilder<RechargeController>(builder: (rechargeController) {
                return CustomButton(
                  isLoading: rechargeController.isLoading,
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      navigate(
                        context: context,
                        page: MobileRechargeSelectOptionsWalletDynamicScreen(),
                      );
                      // navigate(
                      //   context: context,
                      //   page: const WalletEnterPinScreen(
                      //     isMobileRecharge: true,
                      //   ),
                      // );
                    }
                  },
                  child: Text(
                    "Recharge Now",
                    style: Helper(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: white,
                        ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      body: GetBuilder<RechargeController>(builder: (rechargeController) {
        return Padding(
          padding: AppConstants.screenPadding,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomDropDownList(
                    heading: "Select a service provider",
                    items: rechargeController.networkServiceModelList
                        .map((e) => e.networkName)
                        .toList(),
                    itemWidget: rechargeController.networkServiceModelList
                        .map((e) => Row(
                              children: [
                                CustomImage(
                                  path: e.logo,
                                  fit: BoxFit.cover,
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(width: 12),
                                Text(e.networkName),
                              ],
                            ))
                        .toList(),
                    value: rechargeController.selectNetworkOperate?.networkName,
                    onChanged: (value) {
                      rechargeController.selectNetworkOperate =
                          rechargeController.networkServiceModelList.firstWhere(
                        (element) => element.networkName == value,
                      );

                      rechargeController.update();
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Select a service provider";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextFieldWithHeading(
                    controller: rechargeController.mobileNoController,
                    hindText: "91111 1111",
                    hintStyle: Helper(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w600, color: grey),
                    heading: "Enter Mobile Recharge",
                    inputTextStyle:
                        Helper(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                    prefixText: "+91",
                    prefixStyle: Helper(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                    suffix: GestureDetector(
                      onTap: () => mobileRecharge(rechargeController),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: CustomImage(
                          path: Assets.imagesContext,
                          height: 15,
                          width: 14,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a Mobile";
                      }
                      if (value.length != 10) {
                        return "Enter a 10 Digit number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomDropDownList(
                    heading: "Select a State",
                    items: rechargeStateAreaModelList
                        .map((e) => e.areaName)
                        .toList(),
                    hintText: "Orissa",
                    value: rechargeController
                        .selectRechargeStateAreaModel?.areaName,
                    onChanged: (value) {
                      rechargeController.selectRechargeStateAreaModel =
                          rechargeStateAreaModelList.firstWhere(
                        (element) => element.areaName == value,
                      );

                      rechargeController.update();
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please a your state";
                      }
                      return null;
                    },
                  ),
                ],
              )),
        );
      }),
    );
  }
}
