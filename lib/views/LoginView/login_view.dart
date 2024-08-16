import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/images.dart';
import '../../consts/strings.dart';
import '../../controllers/auth_controller.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_text_button.dart';
import '../../res/components/custom_textfield.dart';
import '../Home/home.dart';
import '../SignupView/signup_view.dart';
import '../appointment_view/appointment_view.dart';
import '../forgot_password/forgot_password_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var isDoctor = false;

  final _formKey = GlobalKey<FormState>();

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  final RegExp passwordRegExp = RegExp(
    r'^[a-zA-Z0-9]{6,}$',
  );

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image that does not scroll
            Image.asset(
              AppAssets.login,
              width: 300,
            ),
            const Gap(20),

            // Remaining content that is scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      AppStrings.welcomeBack,
                      style: const TextStyle(fontFamily: "Acme", fontSize: 30),
                    ),
                    const Gap(5),
                    Text(
                      AppStrings.weAreExcited,
                      style: const TextStyle(fontFamily: "Galada", fontSize: 25),
                    ),
                    const Gap(30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: "Email",
                            textController: controller.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: 'Email can\'t be empty',
                                  timeInSecForIosWeb: 2,
                                );
                                return 'Email can\'t be empty';
                              } else if (!emailRegExp.hasMatch(value)) {
                                // Fluttertoast.showToast(
                                //   msg: 'Please enter a valid email address',
                                // );
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const Gap(15),
                          CustomTextField(
                            hint: "Password",
                            obscureText: true, // Obscure the password text
                            textController: controller.passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                // Fluttertoast.showToast(
                                //   msg: 'Password can\'t be empty',
                                // );
                                return 'Password can\'t be empty';
                              } else if (!passwordRegExp.hasMatch(value)) {
                                // Fluttertoast.showToast(
                                //   msg: 'Password must be at least 6 characters long and contain only letters and numbers',
                                // );
                                return 'Password must be at least 6 characters long and\ncontain only letters and numbers';
                              }
                              return null;
                            },
                          ),
                          const Gap(7),
                          SwitchListTile(
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey,
                            value: isDoctor,
                            onChanged: (newValue) {
                              setState(() {
                                isDoctor = newValue;
                              });
                            },
                            title: "Sign in as a doctor".text.make(),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomTextButton(
                              buttonText: "Forgot Password?",
                              onTap: () {
                                Get.to(() => const ForgotPassword());
                              },
                            ),
                          ),
                          const Gap(15),
                          CustomElevatedButton(
                            buttonText: "Login",
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await controller.loginUser();
                                if (controller.userCredential != null) {
                                  if (isDoctor) {
                                    // Signing in as a doctor
                                    Get.to(() => const AppointmentView());
                                  } else {
                                    // Signing in as a user
                                    Get.offAll(() => const Home());
                                  }
                                }
                              }
                            },
                          ),
                          const Gap(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.dontHaveAccount,
                                style: const TextStyle(fontSize: 15),
                              ),
                              const Gap(10),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => const SignupView());
                                },
                                child: const Text("Sign Up"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
