// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/controllers/fund_request_controller.dart';
import 'package:lekra/data/models/user_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/screens/fund_requent_qr/dynamic_qr_sheet.dart';
import 'package:lekra/views/screens/widget/text_box/app_text_box.dart';

class TextBoxAndOptionSection extends StatelessWidget {
  const TextBoxAndOptionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FundRequestController>(builder: (fundRequestController) {
      return Column(
        children: [
          AppTextFieldWithHeading(
            controller: fundRequestController.amountController,
            hindText: "Add Amount",
            borderColor: primaryColor,
            bgColor: white,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Amount is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 38,
            child: ListView.separated(
              itemBuilder: (context, index) {
                final amount = amountList[index];
                return CustomButton(
                  onTap: () {
                    fundRequestController
                        .updateAmountControllerPrice(amount.amount);
                  },
                  color: primaryColor.withValues(alpha: 0.1),
                  child: Text(
                    "₹${amount.amount}",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 18),
              itemCount: amountList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          GetBuilder<AuthController>(builder: (authController) {
            return CustomButton(
              isLoading: fundRequestController.isLoading,
              onTap: () async {
                await fundRequestController
                    .createUPIQR(
                        userModel: authController.userModel ?? UserModel())
                    .then((value) async {
                  if (value.isSuccess) {
                    DynamicQrSheet.show(
                      context,
                    );
                    
                    
                  } else {
                    showToast(message: value.message, typeCheck: value.isBlank);
                  }
                });
              },
              height: 49,
              child: Text(
                "Fetch QR",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: white,
                    ),
              ),
            );
          })
        ],
      );
    });
  }
}

class AmountOptionModel {
  final String amount;

  AmountOptionModel({required this.amount});
}

List<AmountOptionModel> amountList = [
  AmountOptionModel(amount: "100"),
  AmountOptionModel(amount: "200"),
  AmountOptionModel(amount: "500"),
  AmountOptionModel(amount: "1000"),
];
