import 'package:flutter/material.dart';
import 'package:lekra/data/models/fund_reqests/fund_ruquest_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/date_formatters_and_converters.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/fund_request/fund_details_screen/components/row_fund_details.dart';
import 'package:lekra/views/screens/fund_request/fund_request_list_screen/component/fund_status_container.dart';

class FundDetailsContainer extends StatelessWidget {
  final FundRequestsModel? fundRequestsModel;
  const FundDetailsContainer({super.key, required this.fundRequestsModel});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Transaction Amount",
                  overflow: TextOverflow.clip,
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: greyDark,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                DateFormatters()
                    .dMy
                    .format(fundRequestsModel?.createdAt ?? DateTime.now()),
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              fundRequestsModel?.amountFormat ?? "",
              style: Helper(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 34, fontWeight: FontWeight.w500),
            ),
          ),
          StatusChip(
              status: fundRequestsModel?.statusFormat ?? FundStatus.pending),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: grey,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          RowFundDetails(
            label: "Request ID",
            value: fundRequestsModel?.id.toString() ?? "",
          ),
          RowFundDetails(
            label: "UTR",
            value: fundRequestsModel?.utr.toString() ?? "",
            showCopy: true,
          ),
          RowFundDetails(
              label: "Transaction Date",
              value: DateFormatters()
                  .dMy
                  .format(fundRequestsModel?.transDate ?? DateTime.now())),
        ],
      ),
    );
  }
}
