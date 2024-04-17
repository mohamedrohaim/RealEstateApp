import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:realestate/Features/Auth/presentation/cubit/login_user_cubit.dart';
import 'package:realestate/Features/Auth/presentation/pages/send_OTp_forget_Password.dart';
import 'package:realestate/Features/Explore/presentation/pages/explore_screen.dart';
import 'package:realestate/Features/layout/presentation/pages/layout_screen.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/core/widgets/normal_textfomfield.dart';
import 'package:realestate/core/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginUserCubit(),
      child: BlocConsumer<LoginUserCubit, LoginUserState>(
        listener: (context, state) {
          if (state is LoginUserSuccessState) {
            CacheHelper.saveData(key: "token", value: state.loginModel.token);
            CacheHelper.saveData(key: "UserID", value: state.loginModel.userId)
                .then((value) {
              Get.offNamed(RouteName.layoutScreen);
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>const LayoutScreen()));
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: Stack(
            children: [
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/logo.png',
                                height: 315.h,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Login to your account',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            AppTextFormField(
                              controller: emailController,
                              hintText: "emial",
                              type: TextInputType.emailAddress,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "emial must not be empty";
                                }
                              },
                              prefixIcon: Icon(Icons.email),
                            ),
                            BlocProvider.of<LoginUserCubit>(context)
                                .showEmailError(),
                            SizedBox(
                              height: 10.h,
                            ),
                            AppTextFormField(
                              controller: passwordController,
                              hintText: "password",
                              type: TextInputType.visiblePassword,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "password must not be empty";
                                }
                              },
                              prefixIcon: const Icon(Icons.lock),
                            ),
                                BlocProvider.of<LoginUserCubit>(context)
                                .showPasswordError(),
                                verticalSpace(10),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SendOtpRestPassword()));
                                },
                                child: const Text("Forget Password?")),
                            verticalSpace(10),
      
                            SizedBox(height: 10.h),
                            state is LoginUserIsLoadingState
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
                                          log('click');
                                          await BlocProvider.of<LoginUserCubit>(
                                                  context)
                                              .login(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);
                                        }
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 25.h),
                            SocialButton(),
                            SizedBox(height: 10.h),
                            Container(
                              height: 65.h,
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(RouteName.registerScreen);
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}
