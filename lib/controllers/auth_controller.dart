
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  //doctors controller
  var aboutController = TextEditingController();
  var categoryController = TextEditingController();
  var serviceController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var timingController = TextEditingController();

  UserCredential? userCredential;

  isUserAlreadyLogin() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        var data =
        await FirebaseFirestore.instance.collection('doctors').doc(user.uid).get();
        var isDoc = data.data()?['docName'] != null;

        if (isDoc) {
          Get.offAll(() => const AppointmentView(isDoctor: true));
        } else {
          Get.offAll(() => const Home());
        }
      } else {
        Get.offAll(() => const LoginView());
      }
    });
  }

  loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Fluttertoast.showToast(msg: "Login successful");

      this.userCredential = userCredential;
    } catch (e) {
      Fluttertoast.showToast( msg: e.toString());
      Fluttertoast.showToast(msg: "Login failed: $e");
    }
  }


  signupUser(bool isDoctor) async {
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (userCredential != null) {
      await storeUserData(userCredential!.user!.uid, fullNameController.text,
          emailController.text,isDoctor);
    }
  }




  storeUserData(String uid, String fullName, String email,bool isDoctor) async {
    var store = FirebaseFirestore.instance.collection(isDoctor ? 'doctors':'users').doc(uid);
    if(isDoctor){
      await store.set({
        'docAbout':aboutController.text,
        'docCategory':categoryController.text,
        'docService':serviceController.text,
        'docAddress':addressController.text,
        'docPhone':phoneController.text,
        'docTiming':timingController.text,
        'docName':fullName,
        'docId':FirebaseAuth.instance.currentUser?.uid,
        'docRating':1,
        'docEmail':email

      });

    }else{
      await store.set({'fullName': fullName, 'email': email});
    }

  }

  void signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Fluttertoast.showToast(msg: "Sign out successful");
    } catch (e) {
      if (kDebugMode) {
        print("Sign out error: $e");
      }
      Fluttertoast.showToast(msg: "Sign out failed: $e");
    }
  }
}
