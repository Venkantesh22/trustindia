import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class RowOfBankDetails extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const RowOfBankDetails({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w400, color: greyDark),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              value,
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
