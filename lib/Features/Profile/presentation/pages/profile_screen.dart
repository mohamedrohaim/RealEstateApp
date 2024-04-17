import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:realestate/Features/Explore/presentation/widgets/card_widget.dart';
import 'package:realestate/Features/Profile/presentation/widgets/app_bar_profile_screen.dart';
import 'package:realestate/Features/Profile/presentation/widgets/rounded_button.dart';
import 'package:realestate/Features/Profile/presentation/widgets/rounded_image.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/core/utils/spacing.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String city;

  const ProfileScreen({super.key, required this.name, required this.city});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: "token");
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    log(token);
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Column(
        children: [
          const AppBarProfileScreen(),
          const RoundedImage(),
          Text(
            decodedToken['sub'][1],
            style: TextStyle(
                color: AppColor.blackColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "Egypt, Benisufe",
            style: TextStyle(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          verticalSpace(10),
          const RoundedButton(),
          DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: TabBar(
                    labelColor: AppColor.primaryColor,
                    unselectedLabelColor: AppColor.secondColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (index) {},
                    tabs: const [
                      Tab(
                        text: 'Recent view',
                      ),
                      Tab(
                        text: 'History call',
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 380,
                  child: TabBarView(children: [
                    Center(
                        child: Text(
                      "SOON",
                      style: TextStyle(color: Colors.red, fontSize: 24),
                    ))
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
