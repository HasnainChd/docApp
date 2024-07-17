import 'package:flutter/material.dart';

class AboutUsScreeen extends StatelessWidget {
  const AboutUsScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'About Us',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text('''

Welcome to our Doctor Appointment app! We're dedicated to simplifying the process of scheduling and managing your medical appointments. Our platform connects patients with healthcare professionals efficiently, ensuring you receive the care you need when you need it.

We understand the importance of convenient access to healthcare services, which is why we strive to provide a user-friendly experience that empowers you to take control of your health.

Thank you for choosing our app for your healthcare needs. We're committed to continuously improving our services to better serve you.
            ''')
          ],
        ),
      ),
    );
  }
}
