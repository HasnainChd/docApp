import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/images.dart';
import '../../consts/strings.dart';
import '../../controllers/auth_controller.dart';
import '../../res/components/custom_elevated_button.dart';
import '../../res/components/custom_textfield.dart';
import '../Home/home_view.dart';
import '../appointment_view/appointment_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  var isDoctor = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.signUp,
                  width: 150,
                ),
                const Gap(5),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    textAlign: TextAlign.center,
                    AppStrings.signupNow,
                    style: const TextStyle(fontFamily: "Acme", fontSize: 30),
                  ),
                ),
                const Gap(5),
              ],
            ),
            const Gap(30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hint: "Name",
                    textController: controller.fullNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  CustomTextField(
                    hint: "Email",
                    textController: controller.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  CustomTextField(
                    hint: "Password",
                    textController: controller.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  const Gap(15),
                  SwitchListTile(
                    value: isDoctor,
                    onChanged: (newValue) {
                      setState(() {
                        isDoctor = newValue;
                      });
                    },
                    title: "Sign Up as a doctor".text.make(),
                  ),
                  Visibility(
                    visible: isDoctor,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: "About",
                          textController: controller.aboutController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter details about yourself';
                            }
                            return null;
                          },
                        ),
                        const Gap(15),
                        CustomTextField(
                          hint: "Category",
                          textController: controller.categoryController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your category';
                            }
                            return null;
                          },
                        ),
                        const Gap(15),
                        CustomTextField(
                          hint: "Service",
                          textController: controller.serviceController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the service you offer';
                            }
                            return null;
                          },
                        ),
                        const Gap(15),
                        CustomTextField(
                          hint: "Address",
                          textController: controller.addressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        const Gap(15),
                        CustomTextField(
                          hint: "Phone Number",
                          textController: controller.phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 11) {
                              return 'Please enter a valid phone number';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Gap(15),
                        CustomTextField(
                          hint: "Timing",
                          textController: controller.timingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your available timings';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const Gap(40),
                  CustomElevatedButton(
                    buttonText: "Signup",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await controller.signupUser(isDoctor);
                        if (controller.userCredential != null) {
                          Get.off(() => const AppointmentView());
                        } else {
                          Get.off(const HomeView());
                        }
                      }
                    },
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.alreadyHaveAccount,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const Gap(10),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
