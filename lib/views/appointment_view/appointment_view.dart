import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../consts/images.dart';
import '../../controllers/appointment_controller.dart';
import '../../controllers/auth_controller.dart';
import '../appointment_details/appointment_details.dart';


class AppointmentView extends StatelessWidget {
  final bool isDoctor;

  const AppointmentView({super.key, this.isDoctor = false});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Appointments",
          style: TextStyle(color: Colors.white),
        ),
        actions: isDoctor
            ? [
          IconButton(
            onPressed: () {
              AuthController().signout();
            },
            icon: const Icon(Icons.power_settings_new_outlined),
          ),
        ]
            : null, // Hides the button if isDoctor is false
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: controller.getAppointments(isDoctor),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            // Display a message when there are no appointments
            return const Center(
              child: Text(
                'No appointments found.',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error loading appointments.',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Get.to(() => AppointmentDetails(doc: data[index]));
                    },
                    leading: CircleAvatar(
                      child: Image.asset(AppAssets.signUp),
                    ),
                    title: Text(data[index][!isDoctor ? 'appWithName' : 'appName']),
                    subtitle: Text("${data[index]['appDay']} - ${data[index]['appTime']}"),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
