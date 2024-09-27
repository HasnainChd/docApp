import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:medi_app/views/Home/symptoms.dart';
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
  // Symptoms list
  final List symptoms = [
    "Temperature",
    "Snuffle",
    "Fever",
    "Cough",
    "Cold",
  ];

  @override
  Widget build(BuildContext context) {
    // Controllers
    var controller2 = Get.put(SettingController());
    var controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Welcome ${controller2.username.value}',
            style: appTheme.appBarTheme.titleTextStyle,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Container
            searchBar(appTheme.primaryColor, controller, Colors.black),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category text
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
                  // Category
                  SizedBox(
                    height: 100,
                    child: categoryView(appTheme.secondaryHeaderColor, Colors.black),
                  ),
                  const Gap(10),
                  // Symptoms text
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
                  // Symptoms list
                  symptomsList(),
                  const Gap(5),

                  // Popular doctors text
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
                  // Showing data from Firebase
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

  // SearchBar
  Container searchBar(
      Color primaryColor, HomeController controller, Color secondaryColor) {
    return Container(
      padding: const EdgeInsets.all(13),
      color: primaryColor.withOpacity(0.1),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              textController: controller.searchQueryController,
              iconButton: IconButton(
                onPressed: () {
                  if(controller.searchQueryController.text.isNotEmpty){
                    Get.to(
                    () => SearchView(
                        searchQuery: controller.searchQueryController.text),
                  );
                  }
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.blueGrey,
                ),
              ),
              hint: "Search Doctor",
              borderColor: secondaryColor,
              enableColor: Colors.blueGrey,
              textFieldColor: Colors.blueGrey,
              inputColor: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  //symptoms list//listview.builder
  SizedBox symptomsList() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: symptoms.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => SymptomsView(symptom: symptoms[index]));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6FA),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Function to determine gender based on name(not reliable)
  // created latter on when the project about to finish
  String determineGender(String name) {
    if (name.endsWith('a')) {
      return 'female';
    } else {
      return 'male';
    }
  }

  // Categories section
  ListView categoryView(Color secondaryColor, Color textColor) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: iconTitleList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(() => CategoryDetailsView(catName: iconTitleList[index]));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: appTheme.secondaryHeaderColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                // Icon images
                Image.asset(
                  iconList[index],
                  width: 50,
                  height: 50,
                ),
                const SizedBox(height: 5),
                // Icons title
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

  // Popular doctor section
  ListView popularDoctor(List<QueryDocumentSnapshot<Object?>>? data) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final doctorData = data![index];
        final doctorName = doctorData['docName'];
        final gender = determineGender(doctorName);
        final doctorImage =
            gender == 'male' ? AppAssets.male : AppAssets.female;
        return GestureDetector(
          onTap: () {
            Get.to(LoginViewDoctor(doc: doctorData));
          },
          // Container for the doctor's image
          child: Container(
            decoration: BoxDecoration(
              color: appTheme.cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            margin: const EdgeInsets.all(5),
            child: Row(
              children: [
                // Doctor image
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.all(10),
                  child: Image.asset(
                    doctorImage,
                    fit: BoxFit.cover,
                  ),
                ),
                // Doctor name and category
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorName,
                          maxLines: 1,
                          style: appTheme.textTheme.bodyLarge?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          doctorData['docCategory'],
                          style: appTheme.textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
