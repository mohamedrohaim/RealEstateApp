import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Auth/data/model/error_message_model.dart';
import 'package:realestate/Features/Auth/data/model/login_model.dart';
import 'package:realestate/core/network/api_constatn.dart';
import 'package:realestate/core/network/dio_helper.dart';
import 'package:realestate/core/widgets/custom_daliog.dart';


part 'send_confirem_email_otp_state.dart';

class SendConfiremEmailOtpCubit extends Cubit<SendConfiremEmailOtpState> {
  SendConfiremEmailOtpCubit() : super(SendConfiremEmailOtpInitial());
  Future<void> sendConfirmEmailOTP(
      {String? email, String? emailConfirmationToken, String? otpCode}) async {
    emit(SendConfirmEmailIsLoadingState());
    try {
      final response =
          await DioHelper.postUser(url: APIConstant.confrimEmailOTP, data: {
        "email": email,
        "emailConfirmationToken": emailConfirmationToken,
        "otpCode": otpCode
      });
      log(response.data.toString());
      if (response.statusCode == 400) {
        log(response.data.toString());
        emit(SendConfrimEmailErrorState(
            errorMassegeModel: ErrorMassegeModel.fromJson(response.data)));
      }
      var output = LoginModel.fromJson(response.data);
      emit(SendConfrimEmailSuccessState(loginModel: output));
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 400) {
          log(e.response.toString());
          final error = ErrorMassegeModel.fromJson(e.response!.data);
          emit(SendConfrimEmailErrorState(errorMassegeModel: error));
        }
      }
      emit(SendErrorState(error: e.toString()));
    }
  }
    void showCustomDialog(BuildContext context,
      SendConfrimEmailErrorState state, VoidCallback onpresed) {
  //  emit(ShowCustomDialogState());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            alretTitle: state.errorMassegeModel.message.toString(),
            onPresed: onpresed,
          );
        });
  }
}
