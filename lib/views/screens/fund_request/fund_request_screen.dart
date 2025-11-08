import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class FundRequestScreen extends StatefulWidget {
  const FundRequestScreen({super.key});

  @override
  State<FundRequestScreen> createState() => _FundRequestScreenState();
}

class _FundRequestScreenState extends State<FundRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Fund Requests"),
      floatingActionButton: Container(
        child: Container(
          padding:
              const EdgeInsets.only(top: 16, bottom: 16, right: 24, left: 16),
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.add,
                color: white,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                "Add Request",
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              )
            ],
          ),
        ),
      ),
      body: Container(),
    );
  }
}
