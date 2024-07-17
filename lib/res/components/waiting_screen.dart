import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  void initState() {
    AuthController().isUserAlreadyLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          SizedBox(height: 15,),
          Center(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  textAlign: TextAlign.center,
                            'No Internet Connection,Turn on Wifi or Mobile Data to use the App and restart the app',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                          ),
              ))
        ],
      ),
    );
  }
}
