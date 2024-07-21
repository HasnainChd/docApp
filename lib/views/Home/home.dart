import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../consts/colors.dart';
import '../appointment_view/appointment_view.dart';
import '../category/category.dart';
import '../google_map/google_map.dart';
import '../setting/setting_view.dart';
import 'home_view.dart';

class Home extends StatefulWidget {
  const Home({super.key,});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  //this is screen list for bottom navbar
  List screenList = [
    const HomeView(),
    const AppointmentView(),
    MapScreen(),
    const Category(),
    const SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      //bottom navigation bar for showing all tabs
      bottomNavigationBar: CurvedNavigationBar(
        key: GlobalKey(),
        index: selectedIndex,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: selectedIndex == 0 ? appTheme.colorScheme.secondary : Colors.black87),
          Icon(Icons.book, size: 30, color: selectedIndex == 1 ? appTheme.colorScheme.secondary : Colors.black87),
          Icon(Icons.location_on, size: 30, color: selectedIndex == 2 ? appTheme.colorScheme.secondary : Colors.black87),
          Icon(Icons.category, size: 30, color: selectedIndex == 3 ? appTheme.colorScheme.secondary : Colors.black87),
          Icon(Icons.settings, size: 30, color: selectedIndex == 4 ? appTheme.colorScheme.secondary : Colors.black87),
        ],
        color: appTheme.scaffoldBackgroundColor,
        buttonBackgroundColor: appTheme.scaffoldBackgroundColor,
        backgroundColor: appTheme.primaryColor,
        animationCurve: Curves.decelerate,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
