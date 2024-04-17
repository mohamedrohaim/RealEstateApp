import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realestate/core/utils/app_color.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: 93.w,
        height: 33.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.secondColor)),
        child:const  Center(
          child:  Text(
            "Edit Profile",
            style: TextStyle(color: AppColor.primaryColor),
          ),
        ),
      ),
    );
  }
}
