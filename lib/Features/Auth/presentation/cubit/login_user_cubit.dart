import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Auth/data/model/error_model.dart';
import 'package:realestate/Features/Auth/data/model/login_model.dart';
import 'package:realestate/core/network/api_constatn.dart';
import 'package:realestate/core/network/dio_helper.dart';
import 'package:realestate/core/widgets/error_text_widget.dart';


part 'login_user_state.dart';

class LoginUserCubit extends Cubit<LoginUserState> {
  LoginUserCubit() : super(LoginUserInitial());
    String? erroremail = "";
  String? errorpassword = " ";
    Future<void> login({
    String? email,
    String? password,
  }) async {
    emit(LoginUserIsLoadingState());
    try {
      // Either<Failure,void>  response = userLoginUseCase(email.toString() as LoginParms,) as Either<Failure, void>;
      final response = await DioHelper.postUser(url: APIConstant.loginUrl,data: {
        "email":email,
        "password":password,
      });
      //final response = await authMetodsRepository.login(email.toString(),password.toString());
      debugPrint(response.toString());
      if (response.statusCode == 400) {
        debugPrint(response.toString());
        final errormessage = ErrorModel.fromJson(response.data);
        debugPrint(errormessage.emailError.toString());
        debugPrint(errormessage.passwordError.toString());
        emit(LoginUserErrorState(errorModel: errormessage));
      }
      final user = LoginModel.fromJson(response.data);
        emit(LoginUserSuccessState(loginModel: user));
    } catch (error) {
      if (error is DioException) {
        if (error.response!.statusCode == 400) {
          debugPrint(error.response!.statusCode.toString());
          debugPrint(error.response!.data.toString());
          final errormessage =
              ErrorModel.fromJson(error.response!.data);
          erroremail = errormessage.emailError;
          errorpassword = errormessage.passwordError;
          debugPrint(errormessage.emailError.toString());
          debugPrint(errormessage.passwordError.toString());
          emit(LoginUserErrorState(errorModel: errormessage));
        }
      }
      // LoginErrorModel? loginErrorModel;
      emit(LoginErrorState(error: error.toString()));
      rethrow;
    }
  }
    showEmailError() {
    return ErrorTextWidget(
      errormessage: erroremail.toString(),
    );
  }

  showPasswordError() {
    return ErrorTextWidget(
      errormessage: errorpassword.toString(),
    );
  }
}
