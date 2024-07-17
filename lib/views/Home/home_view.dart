import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../../consts/lists.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/setting_controller.dart';
import '../../res/components/custom_textfield.dart';
import '../category_detail_view/category_details_view.dart';
import '../login_view_doctor/login_view_doctor.dart';
import '../search_view/search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //symptoms list
  final List symptoms = [
    "Temperature",
    "Snuffle",
    "Fever",
    "Cough",
    "Cold",
  ];

  @override
  Widget build(BuildContext context) {
    //controllers
    var controller2 = Get.put(SettingController());
    var controller = Get.put(HomeController());

    Color primaryColor = appTheme.primaryColor;
    Color secondaryColor = appTheme.colorScheme.secondary;
    Color textColor = appTheme.textTheme.bodyLarge!.color!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome' " " + controller2.username.value,
          style: appTheme.appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Search Container
            Container(
              padding: const EdgeInsets.all(13),
            color: primaryColor.withOpacity(0.1),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    textController: controller.searchQueryController,
                    iconButton: IconButton(
                      onPressed: () {
                        Get.to(() => SearchView(
                            searchQuery :
                            controller.searchQueryController.text),);
                      },
                      icon: Icon(
                        Icons.search,
                        color: secondaryColor,
                      ),
                    ),
                    hint: "Search Doctor",
                    borderColor: secondaryColor,
                    enableColor: secondaryColor,
                    textFieldColor: secondaryColor,
                    inputColor: secondaryColor,
                  ),
                ),
              ],
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //category text
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Categories",
                      style: appTheme.textTheme.titleLarge?.copyWith(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //category
                  SizedBox(
                    height: 100,
                    child: categoryView(secondaryColor, textColor),
                  ),
                  const Gap(10),
                  //symptoms text
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "What are your symptoms?",
                      style: appTheme.textTheme.titleLarge?.copyWith(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  //symptoms list
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: symptoms.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            color: appTheme.inputDecorationTheme.fillColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              symptoms[index],
                              style: appTheme.textTheme.bodyLarge!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(5),

                  //popular doctors text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Popular Doctors",
                        style: appTheme.textTheme.titleLarge?.copyWith(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Gap(5),
                  //showing data from firebase
                  SizedBox(
                    height: 300, // Set a fixed height for the grid view
                    child: FutureBuilder<QuerySnapshot>(
                      future: controller.getDoctorList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var data = snapshot.data?.docs;
                          return popularDoctor(data);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Categories section
  ListView categoryView(Color secondaryColor, Color textColor) {
    return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => CategoryDetailsView(
                              catName: iconTitleList[index]));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              //icon images
                              Image.asset(
                                iconList[index],
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(height: 5),
                              //icons title
                              Text(
                                iconTitleList[index],
                                style: TextStyle(color: textColor),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
  }

  //popular doctor section
  GridView popularDoctor(List<QueryDocumentSnapshot<Object?>>? data) {
    return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: data?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to((LoginViewDoctor(doc: data[index])));
                              },
                              //container 1 doc image
                              child: Container(
                                decoration: BoxDecoration(
                                  color: appTheme.cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.all(5),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      //container two name and category
                                      Container(
                                        color: Colors.white70,
                                        width: 200,
                                        height: 110,
                                        child: Image.asset(
                                          AppAssets.signUp,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      //doc name and category
                                      Text(
                                        data![index]['docName'],
                                        maxLines: 1,
                                        style: appTheme.textTheme.bodyLarge,
                                      ),
                                      Text(
                                        data[index]['docCategory'],
                                        style: appTheme.textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
  }
}
