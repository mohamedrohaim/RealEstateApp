part of 'login_user_cubit.dart';

sealed class LoginUserState extends Equatable {
  const LoginUserState();

  @override
  List<Object> get props => [];
}

final class LoginUserInitial extends LoginUserState {}

class LoginUserIsLoadingState extends LoginUserState {}

class LoginUserSuccessState extends LoginUserState {
  final LoginModel loginModel;
  LoginUserSuccessState({required this.loginModel});
}

class LoginErrorState extends LoginUserState {
  final String error;
  LoginErrorState({required this.error});
}

class LoginUserErrorState extends LoginUserState {
  final ErrorModel errorModel;
  LoginUserErrorState({required this.errorModel});
}
