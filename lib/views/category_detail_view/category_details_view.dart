import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../consts/images.dart';
import '../login_view_doctor/login_view_doctor.dart';

class CategoryDetailsView extends StatelessWidget {
  final String catName;
  const CategoryDetailsView({super.key,required this.catName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:  Text(catName,style: const TextStyle(
            color: Colors.white
        ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(future: FirebaseFirestore.instance.collection('doctors').where('docCategory',isEqualTo: catName).get(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(),
          );

        }else{
          var data = snapshot.data?.docs;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 170,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8
                ),
                itemCount: data?.length??0,
                itemBuilder: (context, index){
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(

                          width: 130,
                          height: 120,
                          color: Colors.grey.shade500,
                          child: Image.asset(
                            fit: BoxFit.fill,
                            AppAssets.signUp,
                            // fit: BoxFit.cover,
                          ),
                        ),
                         Text(
                          data![index]['docName'],
                          style: const TextStyle(),
                        ),
                        VxRating(onRatingUpdate: (value) {},
                          selectionColor: Colors.yellow,
                          normalColor: Colors.black45,
                          count: 5,
                          maxRating: 5,
                          value: double.parse(data[index]['docRating'].toString()),
                          stepInt: true,
                        ),

                      ],
                    ),
                  ).onTap(() {
                    Get.to(()=>LoginViewDoctor(doc: data[index]));
                  });
                }
            ),
          );
        }
          }),
    );
  }
}
