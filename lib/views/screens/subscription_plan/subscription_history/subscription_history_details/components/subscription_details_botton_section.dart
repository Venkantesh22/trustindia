import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class SubscriptionDetailsBottonSection extends StatelessWidget {
  const SubscriptionDetailsBottonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(35, 16, 35, 10),
          decoration: const BoxDecoration(
              color: whiteBg2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColumnOfPrice(
                    label: "Subscription",
                    value: "Basic Plan",
                  ),
                  ColumnOfPrice(
                    label: "Amount",
                    value: "1900",
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
              ),
              Text(
                '199',
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class ColumnOfPrice extends StatelessWidget {
  final String label;
  final String value;
  const ColumnOfPrice({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Helper(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 15),
        Text(
          value,
          style: Helper(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600, fontSize: 14, color: black),
        ),
      ],
    );
  }
}
