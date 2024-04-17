import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Auth/data/model/register_error.dart';
import 'package:realestate/Features/Auth/data/model/register_succes_model.dart';
import 'package:realestate/core/network/api_constatn.dart';
import 'package:realestate/core/network/dio_helper.dart';


part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  RegisterUserCubit() : super(RegisterUserInitial());
  Future<void> registerUser({
    String? email,
    String? governate,
    String? name,
    String? password,
    String? phoneNumber,
    String? confirmPassword,
  }) async {
    emit(RegisterUserIsloading());
    try {
      final respone =
          await DioHelper.postUser(url: APIConstant.registerUrl, data: {
        "email": email,
        "governate": governate,
        "name": name,
        "password": password,
        "phoneNumber": phoneNumber,
        "confirmPassword": confirmPassword,
      });
      log(respone.data.toString());
      if (respone.statusCode == 400) {
        // log(respone.data.toString());
        final registerError = RegisterError.fromJson(respone.data);
        // log(registerError.title.toString());
        emit(RegisterUserErrorState(registerError: registerError));
      }
      final user = RegisterSuccessModel.fromJson(respone.data);
      //  final outPut = RegisterSuccessModel.fromJson(respone.data);
      emit(RegisterUserSuccessState(registerSuccessModel: user));
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 400) {
          //  log(e.response!.data.toString());
          final registerError = RegisterError.fromJson(e.response!.data);
          //log(registerError.title.toString());
          emit(RegisterUserErrorState(registerError: registerError));
        }
      }
      emit(RegisterErrorState(error: e.toString()));
    }
  }
}
