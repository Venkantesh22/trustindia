import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class CustomButtonForRecharge extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final IconData icon;
  const CustomButtonForRecharge({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: AlignmentGeometry.centerLeft,
            end: AlignmentGeometry.centerRight,
            colors: [
              Color(0xFF0D80F2),
              Color(0xFF0D80F2),
              Color(0xFF074A8C),
            ],
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: black.withValues(alpha: 0.25),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w600, color: white),
            ),
            SizedBox(width: 12),
            Icon(
              icon,
              color: white,
            )
          ],
        ),
      ),
    );
  }
}
