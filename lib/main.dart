import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_app/res/components/waiting_screen.dart';
import 'consts/colors.dart';
import 'firebase_options.dart';
import 'views/Home/home.dart';
import 'views/LoginView/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: appTheme, // Apply the appTheme defined in colors.dart
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Show a waiting screen while the authentication state is being determined
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingScreen();
          }

          // If the user is logged in, navigate to HomeView or other relevant screen
          if (snapshot.hasData) {
            return const Home();
          }

          // If the user is not logged in, show the LoginView
          return const LoginView();
        },
      ),
    );
  }
}
