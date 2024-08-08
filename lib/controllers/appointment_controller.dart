import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;

  var appDayController = TextEditingController();
  var appTimeController = TextEditingController();
  var appPhoneController = TextEditingController();
  var appNameController = TextEditingController();
  var appMessageController = TextEditingController();

  bool validateFields() {
    if (appDayController.text.isEmpty ||
        appTimeController.text.isEmpty ||
        appPhoneController.text.isEmpty ||
        appNameController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> bookAppointment(String docId, String docName, context) async {
    if (!validateFields()) {
      VxToast.show(context, msg: 'Please fill all the fields',
      textColor: Vx.white,textSize: 18,bgColor: Vx.black);
      return;
    }
    isLoading(true);

    var store = FirebaseFirestore.instance.collection('appointments').doc();

    await store.set({
      'appBy': FirebaseAuth.instance.currentUser?.uid,
      'appDay': appDayController.text,
      'appTime': appTimeController.text,
      'appPhone': appPhoneController.text,
      'appName': appNameController.text,
      'appMessage': appMessageController.text,
      'appWith': docId,
      'appWithName': docName,
    });

    isLoading(false);
    VxToast.show(context, msg: 'Appointment is booked Successfully');
    Get.back();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAppointments(bool isDoctor) {
    if (isDoctor) {
      return FirebaseFirestore.instance
          .collection('appointments')
          .where('appWith', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();
    } else {
      return FirebaseFirestore.instance
          .collection('appointments')
          .where('appBy', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();
    }
  }
}
