import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_app/views/setting/terms_conditions.dart';
import '../../consts/images.dart';
import '../../consts/lists.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/setting_controller.dart';
import '../LoginView/login_view.dart';
import 'about_us.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Setting",
          style: TextStyle(color: Colors.white,fontSize: 25),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Image.asset(AppAssets.person),
                    ),
                    title: Text(controller.username.value),
                    subtitle: Text(controller.email.value),
                  ),
                  const Divider(color: Colors.grey),
                  Expanded(
                    child: ListView.builder(
                      itemCount: settingList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            if (index == 2) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Sign-Out"),
                                    content: const Text(
                                      "Are you sure you want to sign out?",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green
                                        ),
                                        child:  const Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red
                                        ),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          await AuthController().signOut();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('SignOut Successfully'),
                                            ),
                                          );
                                          Get.offAll(() => const LoginView());
                                        },
                                        child: const Text(
                                          "Sign Out",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (index == 0) {
                              Get.to(() => const TermsAndConditionsScreen());
                            } else if (index == 1) {
                              Get.to(() => const AboutUsScreeen());
                            }
                          },
                          title: Text(settingList[index]),
                          leading: Icon(
                            settingListIcon[index],size: 25,
                            color: Colors.blue,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
