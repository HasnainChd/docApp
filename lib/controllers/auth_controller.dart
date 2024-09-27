import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../views/Home/home.dart';
import '../views/LoginView/login_view.dart';
import '../views/appointment_view/appointment_view.dart';

class AuthController extends GetxController {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var aboutController = TextEditingController();
  var categoryController = TextEditingController();
  var serviceController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var timingController = TextEditingController();

  UserCredential? userCredential;

  // Check if user is already logged in and redirect based on their role
  void isUserAlreadyLogin() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        var docSnapshot = await FirebaseFirestore.instance.collection('doctors').doc(user.uid).get();
        var isDoctor = docSnapshot.exists; // Check if the logged-in user is a doctor

        if (isDoctor) {
          Get.offAll(() => const AppointmentView(isDoctor: true));
        } else {
          Get.offAll(() => const Home());
        }
      } else {
        Get.offAll(() => const LoginView());
      }
    });
  }

  // Login method for general users
  Future<void> loginUser() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Check if the user is in the 'users' collection
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(userCredential?.user?.uid).get();

      if (userDoc.exists) {
        Fluttertoast.showToast(msg: "Login as User successful");
        Get.offAll(() => const Home());
      } else {
        Fluttertoast.showToast(msg: "This email is not registered as a user.");
        await FirebaseAuth.instance.signOut(); // Sign out the wrongly authenticated user
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Login failed: $e");
    }
  }

  // Login method for doctors
  Future<void> loginDoctor() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Check if the user is in the 'doctors' collection
      var docDoc = await FirebaseFirestore.instance.collection('doctors').doc(userCredential?.user?.uid).get();

      if (docDoc.exists) {
        Fluttertoast.showToast(msg: "Login as Doctor successful");
        Get.offAll(() => const AppointmentView(isDoctor: true));
      } else {
        Fluttertoast.showToast(msg: "This email is not registered as a doctor.");
        await FirebaseAuth.instance.signOut(); // Sign out the wrongly authenticated doctor
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Login failed: $e");
    }
  }

  // Method to sign up either a user or a doctor
  Future<void> signupUser(bool isDoctor) async {
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential != null) {
        await storeUserData(userCredential!.user!.uid, fullNameController.text, emailController.text, isDoctor);
        Fluttertoast.showToast(msg: "Signup successful");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Signup failed: $e");
    }
  }

  // Method to store user or doctor data in Firestore
  Future<void> storeUserData(String uid, String fullName, String email, bool isDoctor) async {
    var store = FirebaseFirestore.instance.collection(isDoctor ? 'doctors' : 'users').doc(uid);

    if (isDoctor) {
      await store.set({
        'docAbout': aboutController.text,
        'docCategory': categoryController.text,
        'docService': serviceController.text,
        'docAddress': addressController.text,
        'docPhone': phoneController.text,
        'docTiming': timingController.text,
        'docName': fullName,
        'docId': FirebaseAuth.instance.currentUser?.uid,
        'docRating': 1,
        'docEmail': email
      });
    } else {
      await store.set({
        'fullName': fullName,
        'email': email
      });
    }
  }

  // Method for signing out
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Fluttertoast.showToast(msg: "Sign out successful");
      Get.offAll(() => const LoginView()); // Clear the navigation stack and return to LoginView
    } catch (e) {
      Fluttertoast.showToast(msg: "Sign out failed: $e");
    }
  }
}
