import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:pinput/pinput.dart';
import 'package:realestate/Features/Auth/presentation/cubit/send_confirem_email_otp_cubit.dart';
import 'package:realestate/Features/Auth/presentation/widgets/custom_button.dart';
import 'package:realestate/core/app_routes/routes_name.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';

class ConfrimEmailScreen extends StatefulWidget {
  const ConfrimEmailScreen(
      {super.key, required this.email, required this.token});
  final String token;
  final String email;
  @override
  State<ConfrimEmailScreen> createState() => _ConfrimEmailScreenState();
}

class _ConfrimEmailScreenState extends State<ConfrimEmailScreen> {
  final otpController = TextEditingController();
  final focusNode = FocusNode();
//  final token=CacheHelper.getData(key: 'token');
//   Map<String,dynamic>decodedToken=JwtDecoder.decode(token);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendConfiremEmailOtpCubit(),
      child: BlocConsumer<SendConfiremEmailOtpCubit, SendConfiremEmailOtpState>(
        listener: (context, state) {
          if (state is SendConfrimEmailSuccessState) {
            CacheHelper.saveData(key: 'UserID', value: state.loginModel.userId);
            CacheHelper.saveData(key: 'token', value: state.loginModel.token);
            Get.toNamed(RouteName.layoutScreen);
          } else if (state is SendConfrimEmailErrorState) {
            BlocProvider.of<SendConfiremEmailOtpCubit>(context)
                .showCustomDialog(context, state, () {
              Navigator.pop(context);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Pleas Enter OTP to Confirm Email'),
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
                  state is SendConfirmEmailIsLoadingState
                      ? CireProgressIndecatorWidget()
                      : CustomButton(
                          onPressed: () {
                            BlocProvider.of<SendConfiremEmailOtpCubit>(context)
                                .sendConfirmEmailOTP(
                                    email: widget.email,
                                    emailConfirmationToken: widget.token,
                                    otpCode: otpController.text);
                          },
                          text: "Send",
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
