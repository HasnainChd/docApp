import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var searchQueryController = TextEditingController();

  // Fetch the list of doctors
  Future<QuerySnapshot<Map<String, dynamic>>> getDoctorList() async {
    var doctors = FirebaseFirestore.instance.collection('doctors').get();
    return doctors;
  }

  // Filter doctors by category
  Future<QuerySnapshot<Map<String, dynamic>>> filterDoctorsByCategory(String category) async {
    var doctors = FirebaseFirestore.instance
        .collection('doctors')
        .where('docCategory', isEqualTo: category)
        .get();
    return doctors;
  }

  // Sort doctors by name in ascending order
  Future<QuerySnapshot<Map<String, dynamic>>> sortDoctorsByNameAscending() async {
    var doctors = FirebaseFirestore.instance
        .collection('doctors')
        .orderBy('docName', descending: false)
        .get();
    return doctors;
  }

  // Sort doctors by name in descending order
  Future<QuerySnapshot<Map<String, dynamic>>> sortDoctorsByNameDescending() async {
    var doctors = FirebaseFirestore.instance
        .collection('doctors')
        .orderBy('docName', descending: true)
        .get();
    return doctors;
  }
}
