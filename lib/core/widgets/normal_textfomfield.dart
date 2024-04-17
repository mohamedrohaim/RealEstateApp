import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realestate/core/utils/app_color.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final bool? isObscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final Color? backgroundColor;
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String?) validator;
  final Function? suffixPressed;
  final Function(String)? onSubmit;
   final VoidCallback? onTap;

  const AppTextFormField({
    super.key,
    required this.hintText,
    this.inputTextStyle,
    this.hintStyle,
    this.isObscureText,
    this.suffixIcon,
    this.focusedBorder,
    this.enabledBorder,
    this.backgroundColor,
    this.onTap,
    this.prefixIcon,
    required this.controller,
    required this.type,
    required this.validator,
    this.suffixPressed,
    this.onSubmit
  });

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        //color: AppColor.greyColor,
        borderRadius: BorderRadius.circular(6),
      ),
      height: 55.h,
      child: TextFormField(
        style: TextStyle(
          color: AppColor.blackColor
        ),
        controller: controller,
        keyboardType: type,
        validator: validator,
        obscureText: isObscureText ?? false,
        onFieldSubmitted: onSubmit,
        onTap: onTap,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: hintStyle ??  TextStyle(
            color: Color(0xFF475569),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 0.10.h,
            letterSpacing: 0.30,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
              onPressed: () {
                suffixPressed!();
              },
              icon: suffixIcon!
          )
              : null,

          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.3,
                  )),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(20)
                  ),
        ),
      ),
    );
  }
}