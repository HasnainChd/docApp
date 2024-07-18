import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_app/consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/images.dart';
import '../login_view_doctor/login_view_doctor.dart';

class SearchView extends StatelessWidget {
  final String searchQuery;
  const SearchView({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Search Results",
            style: TextStyle(color: Colors.white, fontFamily: "Acme"),
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('doctors').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No Doctor Found'),
            );
          }

          var filteredData = snapshot.data?.docs.where((doc) {
            return doc['docName']
                .toString()
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();

          if (filteredData == null || filteredData.isEmpty) {
            return const Center(
              child: Text('No Doctor Found'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 170,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                var doc = filteredData[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(LoginViewDoctor(doc: doc));
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: appTheme.cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 130,
                          height: 120,
                          color: appTheme.cardColor,
                          child: Image.asset(
                            fit: BoxFit.fill,
                            AppAssets.signUp,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              doc['docName'],
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        VxRating(
                          onRatingUpdate: (value) {},
                          selectionColor: Colors.yellow,
                          normalColor: Colors.black45,
                          count: 5,
                          maxRating: 5,
                          value: double.parse(doc['docRating'].toString()),
                          stepInt: true,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
