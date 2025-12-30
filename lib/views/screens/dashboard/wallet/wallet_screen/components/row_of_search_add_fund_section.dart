import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lekra/controllers/wallet_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/common_button.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/fund_request/fund_request_list_screen/fund_request_screen.dart';
import 'package:lekra/views/screens/widget/text_box/app_text_box.dart';

class RowOFSearchAndAddFundButtonSection extends StatelessWidget {
  const RowOFSearchAndAddFundButtonSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(builder: (walletController) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: AppTextFieldWithHeading(
                borderColor: primaryColor,
                controller: walletController.walletSearchController,
                hindText: "Search",
                preFixWidget: const Icon(
                  Icons.search,
                  color: greyBillText,
                ),
                suffix: const Padding(
                  padding: EdgeInsets.all(12),
                  child: CustomImage(
                    path: Assets.imagesCalender,
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            CustomButton(
              onTap: () {
                navigate(context: context, page: const FundRequestScreen());
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.svgsCheckInCircle,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Add Fund",
                    style: Helper(context).textTheme.bodyLarge?.copyWith(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
