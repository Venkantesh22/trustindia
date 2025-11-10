import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class RowFundDetails extends StatelessWidget {
  final String label;
  final String value;
  final bool showCopy;

  const RowFundDetails(
      {super.key,
      required this.label,
      required this.value,
      this.showCopy = false});

  @override
  Widget build(BuildContext context) {
    void copyReferralCode(BuildContext context, String code) {
      Clipboard.setData(ClipboardData(text: code));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Helper(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14, fontWeight: FontWeight.w400, color: greyDark),
        ),
        Row(
          children: [
            Text(
              value,
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (showCopy)
              IconButton(
                onPressed: () => copyReferralCode(context, value),
                icon: Icon(
                  Icons.copy,
                  size: 16,
                  color: primaryColor,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
