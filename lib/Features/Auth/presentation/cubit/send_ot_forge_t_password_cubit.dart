import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Auth/data/model/error_message_model.dart';
import 'package:realestate/Features/Auth/data/model/message_model.dart';
import 'package:realestate/Features/Auth/data/model/succes_otp_model.dart';
import 'package:realestate/core/network/api_constatn.dart';
import 'package:realestate/core/network/api_helper.dart';
import 'package:realestate/core/network/dio_helper.dart';
import 'package:realestate/core/widgets/custom_daliog.dart';

part 'send_ot_forge_t_password_state.dart';

class SendOtForgeTPasswordCubit extends Cubit<SendOtForgeTPasswordState> {
  SendOtForgeTPasswordCubit() : super(SendOtForgeTPasswordInitial());
  Future<void> sendOTPForgetPassword({String? email, String? otp}) async {
    emit(SendForgetPasswordOTPIsLoading());
    try {
      // final response = await DioHelper.postUser(
      //     url: APIConstant.verfiyOTPForgetPassword,
      //     data: {"emai": email, "otp": otp});
      final response = await APIHelper.pustOTPforgetPassowrd(
          {"email": email, "otp": otp},
          APIConstant.baseUrl + APIConstant.verfiyOTPForgetPassword);
      if (response.statusCode == 400) {
        log(response.data.toString());
        var error = ErrorMassegeModel.fromJson(response.data);
        emit(SendForgetPasswordOTPErros(errorMassegeModel: error));
      }
      final output = OTPSendSuccess.fromJson(response.data);
      emit(SendForgetPasswordOTPSuccess(sendSuccess: output));
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 400) {
          final output = e.response!.data;
          log(e.response!.data.toString());
          emit(SendForgetPasswordOTPErros(errorMassegeModel: output));
        }
      }
      emit(SendForgetErrorState(error: e.toString()));
    }
  }

  Future<void> resetForgetPassword(
      {
        String? confirmPassword,
      String? email,
      String? newPassword,
      String? otp,
      String? token
      }) async {
    emit(ResetPasswordIsloadingState());
    try {
      final response = await APIHelper.resetForgetPassword(
        {
  "confirmPassword": confirmPassword,
  "email": email,
  "newPassword": newPassword,
  "otp": otp,
  "token": token
});
      if (response.statusCode == 400) {
        var error = response.data;
        emit(ResetPasswordErrorState(error: error));
      }
      var outPut = MessageModel.fromJson(response.data);
      emit(ResetPasswordSuccesState(messageModel: outPut));
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 400) {
          var error = e.response!.data;
          emit(ResetPasswordErrorState(error: error));
        }
        emit(ResetPasswordError(error: e.toString()));
      }
    }
  }

  void showCustomDialog(BuildContext context,  state,
      VoidCallback onpresed) {
    //  emit(ShowCustomDialogState());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            alretTitle: state.toString(),
            onPresed: onpresed,
          );
        });
  }
}
