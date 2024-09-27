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

  // Search doctors by name or category
  Future<QuerySnapshot<Map<String, dynamic>>> searchDoctors(String searchText) async {
    // First, try searching by name
    var doctorsByName = FirebaseFirestore.instance
        .collection('doctors')
        .where('docName', isEqualTo: searchText)
        .get();

    // If searchText doesn't match a name, search by category
    var doctorsByCategory = FirebaseFirestore.instance
        .collection('doctors')
        .where('docCategory', isEqualTo: searchText)
        .get();

    var doctors = await doctorsByName;

    // If no results found by name, search by category
    if (doctors.docs.isEmpty) {
      doctors = await doctorsByCategory;
    }

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
