import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:realestate/Features/Explore/presentation/cubit/get_unit_cubit.dart';
import 'package:realestate/Features/Explore/presentation/pages/explore_screen.dart';
import 'package:realestate/Features/Favorites/presentation/pages/favoirtes_screen.dart';
import 'package:realestate/Features/Profile/presentation/pages/profile_screen.dart';
import 'package:realestate/Features/layout/presentation/cubit/layout_cubit.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/injection_container.dart' as di;

class LayoutScreen extends StatefulWidget {
  
  const LayoutScreen({super.key,});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentindex = 0;
  List<Widget> screen = [
    ExplorScreen(),
    FavoirtScreen(),
    ProfileScreen(
      city: '',
      name: '',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: screen[currentindex],
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text(
            "AI",
            style: TextStyle(color: AppColor.primaryColor),
          ),
          onPressed: () {
            Get.toNamed(RouteName.aIFormScreem);
          }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:currentindex,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: AppColor.secondColor,
        selectedLabelStyle: const TextStyle(color: AppColor.primaryColor),
        unselectedLabelStyle: const TextStyle(color: AppColor.secondColor),
        backgroundColor: AppColor.whiteColor,
        onTap: (int index) {
          setState(() {
            currentindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: "Favorit"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Account"),
        ],
      ),
    );
  }
}
