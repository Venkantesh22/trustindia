
import 'package:flutter/material.dart';
import 'package:lekra/services/theme.dart';

class AddToCardButton extends StatelessWidget {
  final Function() onTap;

  const AddToCardButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            "Add to Card",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: white,
                ),
          ),
        ),
      ),
    );
  }
}
