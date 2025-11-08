import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/input_decoration.dart';
import 'package:lekra/services/route_helper.dart';
import 'package:lekra/views/screens/auth_screens/forget_password/enter_number_for_opt_screen.dart';
import 'package:lekra/views/screens/auth_screens/signup_screen.dart';
import 'package:lekra/views/screens/dashboard/dashboard_screen.dart';
import 'package:lekra/views/screens/dashboard/home_screen/home_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../services/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;

  final _formKey = GlobalKey<FormState>();
  login(AuthController authController) {
    authController.userLogin().then((value) {
      if (value.isSuccess) {
        navigate(
            context: context,
            type: PageTransitionType.rightToLeft,
            page: const HomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loginPageBg,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: grey.withValues(alpha: 0.3),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: const Offset(0, 4))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "Login to continue",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: GetBuilder<AuthController>(builder: (authController) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        controller: authController.emailController,
                        decoration: CustomDecoration.inputDecoration(
                          hint: "Enter your Email",
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: grey,
                                  ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!GetUtils.isEmail(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Password",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        controller: authController.passwordController,
                        obscureText: !showPassword,
                        decoration: CustomDecoration.inputDecoration(
                          suffix: IconButton(
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: grey,
                            ),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                          hint: "Enter your Password",
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: grey,
                                  ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your Password";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder<AuthController>(builder: (authController) {
                        return GestureDetector(
                          onTap: () async {
                            if (authController.isLoading) {
                              return;
                            }
                            if (_formKey.currentState?.validate() ?? false) {
                              authController.userLogin().then(
                                (value) {
                                  if (value.isSuccess) {
                                    navigate(
                                        context: context,
                                        page: const DashboardScreen(),
                                        isRemoveUntil: true);
                                    showToast(
                                        message: value.message,
                                        typeCheck: value.isSuccess);
                                  } else {
                                    showToast(
                                        message: value.message,
                                        typeCheck: value.isSuccess);
                                  }
                                },
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: authController.isLoading
                                  ? const CircularProgressIndicator(
                                      color: white,
                                    )
                                  : Text(
                                      "Login",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: white,
                                          ),
                                    ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                navigate(
                                    context: context,
                                    page: const EnterNumberForOPTScreen());
                              },
                              child: Text(
                                "Forget password",
                                style: Helper(context).textTheme.bodyMedium,
                              )),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            getCustomRoute(
                              child: const SignUPScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don`t have an account? ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              "Register",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor,
                                  ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
