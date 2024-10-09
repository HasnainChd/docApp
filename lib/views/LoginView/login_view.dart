import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../consts/images.dart';
import '../../consts/strings.dart';
import '../../controllers/auth_controller.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_text_button.dart';
import '../../res/components/custom_textfield.dart';
import '../SignupView/signup_view.dart';
import '../forgot_password/forgot_password_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoadingUser = false;
  bool isLoadingDoctor = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(AppAssets.login, width: 300),
            const Gap(20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(AppStrings.welcomeBack, style: const TextStyle(fontFamily: "Acme", fontSize: 30)),
                    const Gap(5),
                    Text(AppStrings.weAreExcited, style: const TextStyle(fontFamily: "Galada", fontSize: 25)),
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
                                return 'Email can\'t be empty';
                              } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const Gap(15),
                          CustomTextField(
                            hint: "Password",
                            obscureText: true,
                            textController: controller.passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password can\'t be empty';
                              } else if (!RegExp(r'^[a-zA-Z0-9]{6,}$').hasMatch(value)) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  buttonText: "Login as User",
                                  isLoading: isLoadingUser,
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoadingUser = true;
                                      });
                                      await controller.loginUser();
                                      setState(() {
                                        isLoadingUser = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: CustomElevatedButton(
                                  buttonText: "Login as Doctor",
                                  fontSize: 13,
                                  isLoading: isLoadingDoctor,
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoadingDoctor = true;
                                      });
                                      await controller.loginDoctor();
                                      setState(() {
                                        isLoadingDoctor = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Gap(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppStrings.dontHaveAccount, style: const TextStyle(fontSize: 15)),
                              const Gap(10),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => const SignupView());
                                },
                                child: const Text("Sign Up"),
                              ),
                            ],
                          ),
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
