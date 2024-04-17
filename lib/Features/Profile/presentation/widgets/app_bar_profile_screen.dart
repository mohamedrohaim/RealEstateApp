import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realestate/core/utils/app_color.dart';

class AppBarProfileScreen extends StatelessWidget {
  const AppBarProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Profile',
          style: TextStyle(
              color: AppColor.blackColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700),
        ),
        IconButton(
            onPressed: () {
              
            },
            icon: const Icon(Icons.logout),tooltip: 'Logout',)
      ],
    );
  }
}
