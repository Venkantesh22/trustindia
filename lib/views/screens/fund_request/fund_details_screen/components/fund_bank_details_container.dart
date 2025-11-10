import 'package:flutter/material.dart';
import 'package:lekra/data/models/fund_reqests/fund_ruquest_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/fund_request/fund_details_screen/components/row_of_bank_details.dart';

class FundBankDetailsContainer extends StatelessWidget {
  final FundRequestsModel? fundRequestsModel;
  const FundBankDetailsContainer({
    super.key,
    this.fundRequestsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: black.withValues(alpha: 0.1),
                blurRadius: 4,
                spreadRadius: 0,
                offset: const Offset(0, 5))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bank Account ",
            style: Helper(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 28, fontWeight: FontWeight.w500),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              color: grey,
            ),
          ),
          RowOfBankDetails(
              icon: Icons.person_2_outlined,
              label: "Account Name ",
              value: fundRequestsModel?.bankAccount?.accountName ?? "null"),
          SizedBox(
            height: 12,
          ),
          RowOfBankDetails(
              icon: Icons.add_card,
              label: "Account Number",
              value: fundRequestsModel?.bankAccount?.accountNumber ?? "null"),
          SizedBox(
            height: 12,
          ),
          RowOfBankDetails(
              icon: Icons.account_balance,
              label: "IFSC Code ",
              value: fundRequestsModel?.bankAccount?.ifsc ?? "null"),
        ],
      ),
    );
  }
}
