import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:realestate/Features/Auth/presentation/cubit/send_otp_forget_password_cubit.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/core/widgets/normal_textfomfield.dart';


class SendOtpRestPassword extends StatefulWidget {
  const SendOtpRestPassword({super.key});

  @override
  State<SendOtpRestPassword> createState() => _SendOtpRestPasswordState();
}

class _SendOtpRestPasswordState extends State<SendOtpRestPassword> {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendOtpForgetPasswordCubit(),
      child:
          BlocConsumer<SendOtpForgetPasswordCubit, SendOtpForgetPasswordState>(
        listener: (context, state) {
          if (state is SendOTPForgetPasswordSuccesState) {
            BlocProvider.of<SendOtpForgetPasswordCubit>(context)
                .showCustomDialog(context, state, () {
              Get.toNamed(RouteName.confirmOTPForgetPassword,arguments: emailController.text);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Pleas Enter Your Email to \nSend OTP to reset Password',
                          style: TextStyle(
                              color: AppColor.primaryColor, fontSize: 18.sp),
                        )),
                    AppTextFormField(
                      controller: emailController,
                      hintText: "emial",
                      type: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "emial must not be empty";
                        }
                      },
                      prefixIcon: const Icon(Icons.email),
                    ),
                    verticalSpace(16),
                    state is SendOTPForgetPasswordLoadingState
                        ? const CireProgressIndecatorWidget()
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            width: double.infinity,
                            height: 65,
                            child: MaterialButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  // log('click');
                                  BlocProvider.of<SendOtpForgetPasswordCubit>(
                                          context)
                                      .sendOTPForgetPassword(
                                          email: emailController.text);
                                }
                              },
                              child: Text(
                                'Send OTP',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
