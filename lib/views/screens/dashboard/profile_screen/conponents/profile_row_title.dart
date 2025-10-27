import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';

class ProfileRowOfTitle extends StatelessWidget {
  final String title;
  final String value;
  const ProfileRowOfTitle({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF6B7280),
              ),
        ),
        Text(
          value,
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                
              ),
        ),
      ],
    );
  }
}
