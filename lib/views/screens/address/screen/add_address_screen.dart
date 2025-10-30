import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/input_decoration.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/dashboard/profile_screen/profile_screen.dart';
import 'package:lekra/views/screens/checkout/checkout_screen/components/textbox_title.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _fromkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: "Add New Address"),
      body: GetBuilder<BasicController>(builder: (basicController) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: AppConstants.screenPadding,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: black.withValues(alpha: 0.3),
                        offset: const Offset(0, 6),
                        spreadRadius: 0,
                        blurRadius: 6,
                      )
                    ]),
                child: Form(
                  key: _fromkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextboxWithTitle(
                        title: "Street Address",
                        controller: basicController.streetController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Street Address";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextboxWithTitle(
                        title: "City",
                        controller: basicController.cityController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your City";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextboxWithTitle(
                        title: "States",
                        controller: basicController.stateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your states";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Pincode",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        controller: basicController.pincodeController,
                        decoration: CustomDecoration.inputDecoration(
                          hint: "Enter your Pincode ",
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: grey,
                                  ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Pincode";
                          }
                          if (value.length != 6) {
                            return "Please number should be 6 digit";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 22),
                      ProfileButton(
                          title: "Save Address",
                          onPressed: () {
                            if (_fromkey.currentState?.validate() ?? false) {
                              Get.find<BasicController>()
                                  .addAddress()
                                  .then((value) {
                                if (value.isSuccess) {
                                  showToast(
                                      message: value.message,
                                      typeCheck: value.isSuccess);
                                  pop(context);
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
                ),
              ),
            ),
            if (basicController.isLoading)
              Positioned.fill(
                child: Container(
                  color: black.withValues(alpha: 0.4),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
