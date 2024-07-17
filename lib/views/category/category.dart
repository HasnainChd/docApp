import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gap/gap.dart';

import '../../consts/lists.dart';
import '../category_detail_view/category_details_view.dart';

class Category extends StatelessWidget {
  const Category({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Specialist",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 13,
            mainAxisExtent: 230,
          ),
          itemCount: iconList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(CategoryDetailsView(
                  catName: iconTitleList[index],
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade300,
                      Colors.blueAccent.shade200,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        iconList[index],
                        width: 120,
                        height: 120,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      iconTitleList[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
