import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Auth/data/model/error_message_model.dart';
import 'package:realestate/Features/Auth/data/model/message_model.dart';
import 'package:realestate/core/network/api_constatn.dart';
import 'package:realestate/core/network/dio_helper.dart';
import 'package:realestate/core/widgets/custom_daliog.dart';


part 'send_otp_forget_password_state.dart';

class SendOtpForgetPasswordCubit extends Cubit<SendOtpForgetPasswordState> {
  SendOtpForgetPasswordCubit() : super(SendOtpResetPasswordInitial());
  Future<void> sendOTPForgetPassword({String? email}) async {
    emit(SendOTPForgetPasswordLoadingState());
    try {
      final response = await DioHelper.postUser(
          url: APIConstant.sendOTPForgetPassword, data: {"email": email});
      debugPrint(response.toString());
      if (response.statusCode == 400) {
        debugPrint(response.toString());
        final errormessage = ErrorMassegeModel.fromJson(response.data);
        emit(SendOTPForegtPasswordErrorState(errorMassegeModel: errormessage));
      }
      final message = MessageModel.fromJson(response.data);
      //// debugPrint(response.data);
      emit(SendOTPForgetPasswordSuccesState(message: MessageModel.fromJson(response.data)));
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 400) {
          debugPrint(e.toString());
          final errormessage = ErrorMassegeModel.fromJson(e.response!.data);
          emit(
              SendOTPForegtPasswordErrorState(errorMassegeModel: errormessage));
        }
      }
      emit(SendOTPErrorState(error: e.toString()));
    }
  }

  void showCustomDialog(BuildContext context,
      SendOTPForgetPasswordSuccesState state, VoidCallback onpresed) {
    emit(ShowCustomDialogState());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            alretTitle: state.message.message.toString(),
            onPresed: onpresed,
          );
        });
  }
}
