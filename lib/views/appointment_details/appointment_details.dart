import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';

class AppointmentDetails extends StatelessWidget {
  final DocumentSnapshot doc;
  const AppointmentDetails({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          doc['appWithName'],
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select appointment day",
            style: TextStyle(fontWeight: FontWeight.bold,),
          ),
          const Gap(10),
          Text(
            doc['appDay'],
            style: const TextStyle(fontWeight: FontWeight.bold, ),
          ),
          const Gap(20),
          const Text(
            "Select appointment time",
            style: TextStyle(fontWeight: FontWeight.bold,),
          ),
          const Gap(10),
          Text(
            doc['appTime'],
            style: const TextStyle(fontWeight: FontWeight.bold,),
          ),
          const Gap(20),
          const Text(
            "Mobile Number",
            style: TextStyle(fontWeight: FontWeight.bold, ),
          ),
          const Gap(10),
          Text(
            doc['appPhone'],
            style: const TextStyle(fontWeight: FontWeight.bold,),
          ),
          const Gap(20),
          const Text(
            "Full Name",
            style: TextStyle(fontWeight: FontWeight.bold,),
          ),
          const Gap(10),
          Text(
            doc['appName'],
            style: const TextStyle(fontWeight: FontWeight.bold, ),
          ),
          const Gap(20),
          const Text(
            "Message",
            style: TextStyle(fontWeight: FontWeight.bold,),
          ),
          const Gap(10),
          Text(
            doc['appMessage'],
            style: const TextStyle(fontWeight: FontWeight.bold,),
          ),
        ],
      ),
    );
  }
}
