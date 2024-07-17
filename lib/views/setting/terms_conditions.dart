import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text('''Terms and Conditions for Doctor Appointment App

1. Introduction

These Terms and Conditions govern your use of the Doctor Appointment App (referred to as "the App"), provided by [Company Name]. By using the App, you agree to these Terms and Conditions. If you do not agree with any part of these terms, you must not use the App.

2. Use of the App

2.1. The App is intended for individuals seeking to schedule appointments with healthcare providers.

2.2. You must be at least 18 years old to use the App. By using the App, you confirm that you are at least 18 years old.

2.3. You agree to provide accurate and complete information when using the App.

3. Appointment Booking

3.1. The App allows users to schedule appointments with healthcare providers listed on the platform.

3.2. Appointment availability is subject to the discretion of the healthcare provider and may vary based on their schedule.

3.3. The App does not guarantee the availability of specific appointment times.

4. Healthcare Provider Information

4.1. The App provides information about healthcare providers, including their qualifications, specialties, and availability.

4.2. While we strive to provide accurate information, we do not guarantee the accuracy, completeness, or reliability of the information provided.

5. Fees and Payments

5.1. The use of the App is free for users.

5.2. Healthcare services provided by the healthcare providers listed on the App may be subject to fees. Any fees or payments for healthcare services are solely between you and the healthcare provider.

6. Privacy

6.1. We respect your privacy and are committed to protecting your personal information. Please refer to our Privacy Policy for details on how we collect, use, and disclose your information.

7. User Conduct

7.1. You agree to use the App in compliance with all applicable laws and regulations.

7.2. You agree not to use the App for any unlawful or prohibited purpose.

8. Limitation of Liability

8.1. To the extent permitted by law, we shall not be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in any way connected with your use of the App.

9. Changes to Terms and Conditions

9.1. We reserve the right to modify these Terms and Conditions at any time. Any changes will be effective immediately upon posting on the App. Your continued use of the App after the posting of changes constitutes your acceptance of such changes.

10. Governing Law

10.1. These Terms and Conditions shall be governed by and construed in accordance with the laws of [Jurisdiction].

11. Contact Us

11.1. If you have any questions or concerns about these Terms and Conditions, please contact us at [Contact Information].          
            
            '''),
          ],
        ),
      ),
    );
  }
}
