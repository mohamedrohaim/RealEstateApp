import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:realestate/Features/Auth/presentation/cubit/register_user_cubit.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/app_constant.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/core/widgets/normal_textfomfield.dart';
import 'package:realestate/core/widgets/social_button.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmationPasswordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var nameController = TextEditingController();
  String? selectedCity;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadCities();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterUserCubit(),
      child: BlocConsumer<RegisterUserCubit, RegisterUserState>(
        listener: (contxt, state) {
          if (state is RegisterUserSuccessState) {
            CacheHelper.saveData(
                    key: "token",
                    value: state.registerSuccessModel.emailConfirmationToken)
                .then((value) {
              Get.toNamed(RouteName.confrimEmailScreen,arguments: {"email":emailController.text,"token":state.registerSuccessModel.emailConfirmationToken.toString()});
            });
          } else if (state is RegisterUserErrorState) {
            //log(state.registerError.errors.toString());
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.registerError.errors.toString())));
          } else if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error.toString())));
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: Stack(
            children: [
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/logo.png',
                              height: 300,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text('register your account',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              )),
                          AppTextFormField(
                            controller: emailController,
                            hintText: "Enter Email",
                            type: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "email must not be empty";
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                return 'Please enter a valid email';
                              }
                            },
                          ),
                          verticalSpace(10),
                          DropdownButton(
                            value: selectedCity,
                            items: cities.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                  child: Text(value), value: value);
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCity = newValue;
                              });
                              debugPrint(selectedCity);
                            },
                            hint: const Text("Selected a City"),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextFormField(
                              hintText: "Enter your name",
                              controller: nameController,
                              type: TextInputType.name,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "name must not be empty";
                                }
                              }),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextFormField(
                              hintText: "Enter your Phone",
                              controller: phoneNumberController,
                              type: TextInputType.phone,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "phone must not be empty";
                                }
                              }),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextFormField(
                              hintText: "Enter Password",
                              isObscureText: true,
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter Password';
                                }
                                if (value.length < 8) {
                                  return 'Password should be at least 8 characters.';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextFormField(
                              hintText: "ReEnter Password",
                              isObscureText: true,
                              controller: confirmationPasswordController,
                              type: TextInputType.visiblePassword,
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter Password';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 10.h,
                          ),
                          state is RegisterUserIsloading
                              ? const CireProgressIndecatorWidget()
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: double.infinity,
                                  height: 60.h,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<RegisterUserCubit>(
                                                context)
                                            .registerUser(
                                                email: emailController.text,
                                                governate: selectedCity,
                                                name: nameController.text,
                                                password:
                                                    passwordController.text,
                                                phoneNumber:
                                                    phoneNumberController.text,
                                                confirmPassword:
                                                    confirmationPasswordController
                                                        .text);
                                      }
                                    },
                                    child: Text(
                                      state is RegisterUserErrorState
                                          ? 'Error'
                                          : "Register",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SocialButton(),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account! ',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(RouteName.loginScreen);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) {
                                  //     return loginScreen();
                                  //   }),
                                  // );
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
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

  void register() {
    if (formKey.currentState?.validate() == true) {}
  }
}
