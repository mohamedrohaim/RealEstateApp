part of 'register_user_cubit.dart';

sealed class RegisterUserState extends Equatable {
  const RegisterUserState();

  @override
  List<Object> get props => [];
}

final class RegisterUserInitial extends RegisterUserState {}

class RegisterUserIsloading extends RegisterUserState {}

class RegisterUserErrorState extends RegisterUserState {
  final RegisterError registerError;
  RegisterUserErrorState({required this.registerError});
}

class RegisterUserSuccessState extends RegisterUserState {
  final RegisterSuccessModel registerSuccessModel;
  RegisterUserSuccessState({required this.registerSuccessModel});
}

class RegisterErrorState extends RegisterUserState {
  final String error;
  RegisterErrorState({required this.error});
}
