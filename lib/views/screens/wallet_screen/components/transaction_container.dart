import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lekra/data/models/transaction_model.dart.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class TransactionsContainer extends StatelessWidget {
  final TransactionModel transactionModel;
  const TransactionsContainer({
    super.key,
    required this.transactionModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: white,
          boxShadow: [
            BoxShadow(
                color: black.withValues(alpha: 0.1),
                spreadRadius: 0,
                blurRadius: 6,
                offset: const Offset(0, 4))
          ]),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(transactionModel.description),
                  style: Helper(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat()
                      .format(transactionModel.createdAt ?? DateTime.now()),
                  style: Helper(context).textTheme.bodySmall?.copyWith(),
                ),
              ],
            ),
          ),
          Text(
            transactionModel.isDebit ? "-" : "+",
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: transactionModel.isDebit ? red : green),
          ),
          Text(
            PriceConverter.convertToNumberFormat(
                transactionModel.amount ?? 111),
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: transactionModel.isDebit ? red : green),
          ),
        ],
      ),
    );
  }
}
