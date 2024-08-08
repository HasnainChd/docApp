import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../../res/components/custom_elevated_button.dart';
import '../book_appointment_view/book_appointment_view.dart';  // Import the colors.dart file

class LoginViewDoctor extends StatelessWidget {
  final DocumentSnapshot doc;
  const LoginViewDoctor({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.appBarTheme.backgroundColor, // Use the app bar color from the theme
        title: const Text(
          "Doctor Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // First container for doctor profile name and category
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 2.0),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: appTheme.primaryColor,
                    radius: 40,
                    backgroundImage: AssetImage(AppAssets.signUp),
                  ),
                  const Gap(10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text for doc name
                        Text(
                          doc['docName'],
                          style: appTheme.textTheme.bodyLarge, // Use the text style from the theme
                          textDirection: TextDirection.ltr,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const Gap(5),
                        //doc category
                        Text(
                          doc['docCategory'],
                          style: appTheme.textTheme.bodyLarge?.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Second container with fixed height for doctor details
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade400, width: 2.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  Text("Phone Number", style: appTheme.textTheme.bodyLarge),
                  const SizedBox(height: 5),
                  Text(doc['docPhone'], style: appTheme.textTheme.bodyLarge?.copyWith(color: Colors.red)),
                  const SizedBox(height: 10),
                  Text("About", style: appTheme.textTheme.bodyLarge),
                  const SizedBox(height: 5),
                  Text(doc['docAbout'], style: appTheme.textTheme.bodyLarge?.copyWith(color: Colors.red)),
                  const SizedBox(height: 10),
                  Text("Address", style: appTheme.textTheme.bodyLarge),
                  const SizedBox(height: 5),
                  Text(doc['docAddress'], style: appTheme.textTheme.bodyLarge?.copyWith(color: Colors.red)),
                  const SizedBox(height: 10),
                  Text("Working Time", style: appTheme.textTheme.bodyLarge),
                  const SizedBox(height: 5),
                  Text(doc['docTiming'], style: appTheme.textTheme.bodyLarge?.copyWith(color: Colors.red)),
                  const SizedBox(height: 10),
                  Text("Services", style: appTheme.textTheme.bodyLarge),
                  const SizedBox(height: 5),
                  Text(doc['docService'], style: appTheme.textTheme.bodyLarge?.copyWith(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomElevatedButton(
          buttonText: "Book an appointment",
          onTap: () {
            Get.to(
                  () => BookAppointmentView(
                docId: doc['docId'],
                docName: doc['docName'],
              ),
            );
          },
        ),
      ),
    );
  }
}
