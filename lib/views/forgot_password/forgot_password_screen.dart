import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../consts/images.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.forgot,
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                textAlign: TextAlign.center,
                'Please enter a valid email Address to send a link via email to create a new Password',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Email",
                  suffixIcon: Icon(Icons.mail),
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              SizedBox(
                height: 40,
                width: 180,
                child: ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Enter Your Email");
                    } else {
                      await forgotPasswordWithEmail(emailController.text.trim());
                    }
                    emailController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  child: const Text("Send Email"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> forgotPasswordWithEmail(String email) async {
  try {
    if (kDebugMode) {
      print('Sending password reset to $email');
    }
   await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    if (kDebugMode) {
      print('Password reset email sent to $email');
    }
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Fluttertoast.showToast(
      msg: 'an Email is sent to your email address',
      timeInSecForIosWeb: 2,
    );
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(
      msg: e.code.toString(),
      timeInSecForIosWeb: 2,
    );
  }
}
