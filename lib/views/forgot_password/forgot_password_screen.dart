import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
                suffixIcon: Icon(Icons.mail),
              ),
            ),
          ),
          const SizedBox(
            height: 35.0,
          ),
          SizedBox(
            height: 40,
            width: 180,
            child: ElevatedButton(
              onPressed: () {
                forgotPasswordWithEmail(emailController.text.trim());
                emailController.clear();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, foregroundColor: Colors.white),
              child: const Text("Forgot Password"),
            ),
          ),
        ],
      ),
    );
  }
}

void forgotPasswordWithEmail(String email) async {
  if (email == ' ') {
    Fluttertoast.showToast(msg: "Enter Your Email");
  } else {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
          (value) => Fluttertoast.showToast(
              msg: 'email is send to your email address'));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.code.toString());
    }
  }
}
