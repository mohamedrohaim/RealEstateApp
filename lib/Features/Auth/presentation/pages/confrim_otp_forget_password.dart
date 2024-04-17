import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:pinput/pinput.dart';
import 'package:realestate/Features/Auth/presentation/cubit/send_ot_forge_t_password_cubit.dart';
import 'package:realestate/Features/Auth/presentation/widgets/custom_button.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';

class ConfirmOTPForgetPassword extends StatefulWidget {
  const ConfirmOTPForgetPassword({super.key, required this.emial});
  final String emial;
  @override
  State<ConfirmOTPForgetPassword> createState() =>
      _ConfirmOTPForgetPasswordState();
}

class _ConfirmOTPForgetPasswordState extends State<ConfirmOTPForgetPassword> {
  final otpController = TextEditingController();
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendOtForgeTPasswordCubit(),
      child: BlocConsumer<SendOtForgeTPasswordCubit, SendOtForgeTPasswordState>(
          builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Pleas Enter OTP to Resete Password'),
                verticalSpace(20),
                Pinput(
                  length: 6,
                  controller: otpController,
                  focusNode: focusNode,
                  validator: (value) {
                    if (value != otpController.text) {
                      return "pleas check otp again";
                    }
                    return null;
                  },
                ),
                verticalSpace(20),
                state is SendForgetPasswordOTPIsLoading
                    ? CireProgressIndecatorWidget()
                    : CustomButton(
                        onPressed: () {
                          log(widget.emial.toString());
                          log(otpController.text.toString());
                          BlocProvider.of<SendOtForgeTPasswordCubit>(context)
                              .sendOTPForgetPassword(
                                  email: widget.emial,
                                  otp: otpController.text.toString());
                        },
                        text: "Send",
                      ),
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is SendForgetPasswordOTPSuccess) {
          Get.toNamed(RouteName.restPasswordScreen,arguments: {
            "email":widget.emial,
            "token":state.sendSuccess.restPasswordToken,
            "otp":otpController.text
          });
        } else if (state is SendForgetPasswordOTPErros) {
          BlocProvider.of<SendOtForgeTPasswordCubit>(context)
              .showCustomDialog(context, state, () {});
        }
      }),
    );
  }
}
