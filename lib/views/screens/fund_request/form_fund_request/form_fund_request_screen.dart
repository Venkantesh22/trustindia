import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/fund_request_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/date_formatters_and_converters.dart';
import 'package:lekra/services/input_decoration.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/checkout/checkout_screen/components/textbox_title.dart';
import 'package:lekra/views/screens/dashboard/profile_screen/profile_screen.dart';
import 'package:lekra/views/screens/fund_request/fund_request_list_screen/fund_request_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class FormFundRequestScreen extends StatefulWidget {
  const FormFundRequestScreen({super.key});

  @override
  State<FormFundRequestScreen> createState() => _FormFundRequestScreenState();
}

class _FormFundRequestScreenState extends State<FormFundRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<FundRequestController>().getAssignBank();
    });
  }

  Future<void> pickDate(FundRequestController controller) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 5),
      helpText: 'Select transaction date',
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.light(
            primary: primaryColor,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      controller.dateController.text =
          DateFormatters().dMyDash.format(picked); // dd-MM-yyyy
      controller.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Add Fund Request"),
      body: Padding(
        padding: AppConstants.screenPadding,
        child: GetBuilder<FundRequestController>(
          builder: (fundRequestController) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          "Select Date",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 6),

                        // ✅ DATE FIELD – uses dateController (not UTR)
                        TextFormField(
                          controller: fundRequestController.dateController,
                          readOnly: true,
                          onTap: () => pickDate(fundRequestController),
                          decoration: CustomDecoration.inputDecoration(
                            hint: "Select Date of transaction",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: grey,
                                ),
                            suffix: const Icon(Icons.calendar_today, size: 18),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select transaction date";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        CustomTextboxWithTitle(
                            controller: fundRequestController.utrNoController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your UTR number";
                              }
                              return null;
                            },
                            title: "UTR Number"),

                        const SizedBox(height: 16),
                        Text(
                          "Enter amount",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 6),

                        TextFormField(
                          controller: fundRequestController.amountController,
                          decoration: CustomDecoration.inputDecoration(
                            hint: "Please enter your amount",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: grey,
                                ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your amount";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        Text(
                          "Select Bank",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          initialValue:
                              fundRequestController.selectedBank?.accountName,
                          isExpanded: true,
                          items: fundRequestController.bankList
                              .map((bank) => bank.accountName)
                              .toList()
                              .map((b) => DropdownMenuItem<String>(
                                    value: b,
                                    child: Text(b ?? ""),
                                  ))
                              .toList(),
                          onChanged: (v) => fundRequestController.setBank(v),
                          style: Helper(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                          hint: Text(
                            "Choose your bank",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: grey,
                                ),
                          ),
                          dropdownColor: greyBorder,
                          decoration: CustomDecoration.dropdown(
                            context,
                            label: "Choose your bank",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: grey,
                                ),
                          ),
                          validator: (v) => (v == null || v.isEmpty)
                              ? "Please select a bank"
                              : null,
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  ProfileButton(
                      isLoading: fundRequestController.isLoading,
                      title: "Submit Request",
                      onPressed: () {
                        if (fundRequestController.isLoading) {
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          fundRequestController.postFundRequest().then((value) {
                            if (value.isSuccess) {
                              showToast(
                                  message: value.message,
                                  typeCheck: value.isSuccess);
                              navigate(
                                context: context,
                                page: FundRequestScreen(),
                              );
                            } else {
                              showToast(
                                  message: value.message,
                                  typeCheck: value.isSuccess);
                            }
                          });
                        }
                      },
                      color: primaryColor)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
