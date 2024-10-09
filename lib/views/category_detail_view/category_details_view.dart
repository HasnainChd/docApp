import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../consts/images.dart';
import '../login_view_doctor/login_view_doctor.dart';

class CategoryDetailsView extends StatelessWidget {
  final String catName;

  const CategoryDetailsView({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          catName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('doctors')
              .where('docCategory', isEqualTo: catName)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.red,),
              );
            } else {
              var data = snapshot.data?.docs;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                //show all doctor when we click on a specific category
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 170,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,),
                    itemCount: data?.length ?? 0,
                    itemBuilder: (context, index) {
                      //background container
                      return Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //image container
                            Container(
                              width: 130,
                              height: 120,
                              color: Colors.grey.shade500,
                              child: Image.asset(
                                width: double.infinity,
                                AppAssets.signUp,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              data![index]['docName'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ).onTap(() {
                        Get.to(() => LoginViewDoctor(doc: data[index]));
                      });
                    }),
              );
            }
          }),
    );
  }
}
