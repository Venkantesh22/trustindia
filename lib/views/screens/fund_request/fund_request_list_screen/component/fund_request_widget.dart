import 'package:flutter/material.dart';
import 'package:lekra/data/models/fund_reqests/fund_ruquest_model.dart';
import 'package:lekra/services/date_formatters_and_converters.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/fund_request/fund_request_list_screen/component/fund_status_container.dart';

/// Card widget
class FundRequestCard extends StatelessWidget {
  const FundRequestCard({
    super.key,
    required this.fundRequestModel,
    required this.onTapView,
  });

  final FundRequestModel fundRequestModel;
  final VoidCallback onTapView;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: greyBorder),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header: ID + Date/Time
          Row(
            children: [
              Expanded(
                child: Text(
                  '#${fundRequestModel.id}',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                DateFormatters().dMonthYear.format(fundRequestModel.dateTime),
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(height: 1, color: greyBorder),
          const SizedBox(height: 12),

          // Details grid (2 columns on wide, 1 on narrow)
          _detailRow('UTR No.', fundRequestModel.utr),
          const SizedBox(height: 8),
          _detailRow('Bank Name', fundRequestModel.bank),
          const SizedBox(height: 8),
          _detailRow(
            'Amount',
            '₹ ${fundRequestModel.amount.toStringAsFixed(2)}',
            valueStyle: TextStyle(
              color: secondaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),

          // Status + optional actions
          Row(
            children: [
              StatusChip(status: fundRequestModel.status, onTapView: onTapView),
              const Spacer(),
            ],
          ),

          // Cancellation reason (only when cancelled)
          if (fundRequestModel.status == FundStatus.cancelled &&
              (fundRequestModel.cancelReason ?? '').isNotEmpty) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Reason: ${fundRequestModel.cancelReason}',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

Widget _detailRow(
  String label,
  String value, {
  TextStyle? valueStyle,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 110,
        child: Text(
          label,
          style: TextStyle(
            color: secondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          value,
          style: valueStyle ??
              TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
        ),
      ),
    ],
  );
}
