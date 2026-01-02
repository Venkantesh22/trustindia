import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/date_formatters_and_converters.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_history/subscription_history_details/components/row_of_subscription_details.dart';
import 'package:lekra/views/screens/subscription_plan/subscription_history/subscription_history_screen/components/subscription_status_container.dart';

class SubscriptionDetailsTopSection extends StatelessWidget {
  const SubscriptionDetailsTopSection({super.key});
  Future copyText({required String text, required BuildContext context}) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      showToast(message: "copy : $text", toastType: ToastType.info);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 24,
          ),
          decoration: BoxDecoration(
            color: whiteBg2,
            border: Border.all(color: grey.withValues(alpha: 0.50)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const RowOfSubscriptionDetails(
                label: "Basic Membership",
                value: SubscriptionStatusContainer(),
              ),
              const SizedBox(height: 24),
              RowOfSubscriptionDetails(
                label: "UPI transaction ID",
                value: Row(
                  children: [
                    Text(
                      "5390789193866",
                      style: Helper(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: greyAccountText, fontSize: 14),
                    ),
                    IconButton(
                        tooltip: "copy ID",
                        onPressed: () {
                          copyText(text: "5390789193866", context: context);
                        },
                        icon: const Icon(Icons.file_copy_rounded))
                  ],
                ),
              ),
              const SizedBox(height: 24),
              RowOfSubscriptionDetails(
                label: "Date and Time",
                value: Row(
                  children: [
                    Text(
                      DateFormatters().dMonthYear.format(getDateTime()),
                      style: Helper(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: greyAccountText, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              RowOfSubscriptionDetails(
                label: "Payment Status",
                value: Row(
                  children: [
                    Text(
                      "Paid",
                      style: Helper(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: greyAccountText, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
