import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:realestate/Features/Auth/presentation/cubit/send_ot_forge_t_password_cubit.dart';
import 'package:realestate/Features/Auth/presentation/cubit/send_otp_forget_password_cubit.dart';
import 'package:realestate/Features/Auth/presentation/widgets/custom_button.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/utils/app_color.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/core/widgets/custom_daliog.dart';
import 'package:realestate/core/widgets/normal_textfomfield.dart';
import 'package:realestate/core/widgets/titles_text_widget.dart';

class RestPasswordScreen extends StatefulWidget {
  final String email, token, otp;
  const RestPasswordScreen(
      {super.key, required this.email, required this.token, required this.otp});

  @override
  State<RestPasswordScreen> createState() => _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  ///var emailController = TextEditingController();
  var confirmationPasswordController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendOtForgeTPasswordCubit(),
      child: BlocConsumer<SendOtForgeTPasswordCubit, SendOtForgeTPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccesState) {
            log('success');
            log(state.messageModel.message.toString());
            BlocProvider.of<SendOtForgeTPasswordCubit>(context)
                .showCustomDialog(
                    context, state.messageModel.message.toString(), () {
              Get.offNamed(RouteName.loginScreen);
            });
            //  CustomAlertDialog
          } else if (state is ResetPasswordErrorState) {
            log(state.error.toString());
          } else if (state is ResetPasswordError) {
            log(state.error.toString());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TitlesTextWidget(
                    label: "Reset Your Password Here",
                    color: AppColor.primaryColor,
                    fontSize: 18,
                  ),
                  verticalSpace(10),
                  Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // AppTextFormField(
                            //   controller: emailController,
                            //   hintText: "Enter Email",
                            //   type: TextInputType.emailAddress,
                            //   validator: (String? value) {
                            //     if (value!.isEmpty) {
                            //       return "email must not be empty";
                            //     }
                            //     bool emailValid = RegExp(
                            //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            //         .hasMatch(value);
                            //     if (!emailValid) {
                            //       return 'Please enter a valid email';
                            //     }
                            //   },
                            // ),
                            // verticalSpace(10),
                            AppTextFormField(
                                hintText: "Enter Password",
                                isObscureText: true,
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter Password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password should be at least 6 characters.';
                                  }
                                  return null;
                                }),
                            verticalSpace(10),
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
                            verticalSpace(10),
                            state is ResetPasswordIsloadingState
                                ? CireProgressIndecatorWidget()
                                : CustomButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        log(widget.email.toString());
                                        log(widget.token.toString());
                                        log(widget.otp.toString());
                                        BlocProvider.of<
                                                    SendOtForgeTPasswordCubit>(
                                                context)
                                            .resetForgetPassword(
                                          confirmPassword:
                                              confirmationPasswordController
                                                  .text,
                                          email: widget.email,
                                          newPassword: passwordController.text,
                                          otp: widget.otp,
                                          token: widget.token,
                                        );
                                      }
                                    },
                                    text: "Reset")
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
