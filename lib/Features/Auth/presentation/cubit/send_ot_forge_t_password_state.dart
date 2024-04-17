part of 'send_ot_forge_t_password_cubit.dart';

sealed class SendOtForgeTPasswordState extends Equatable {
  const SendOtForgeTPasswordState();

  @override
  List<Object> get props => [];
}

final class SendOtForgeTPasswordInitial extends SendOtForgeTPasswordState {}

//class SendOTPForgetPasswordIsloading extension SendOtForgeTPasswordState{}
class SendForgetPasswordOTPIsLoading extends SendOtForgeTPasswordState {}

class SendForgetPasswordOTPSuccess extends SendOtForgeTPasswordState {
  final OTPSendSuccess sendSuccess;
  SendForgetPasswordOTPSuccess({required this.sendSuccess});
}

class SendForgetPasswordOTPErros extends SendOtForgeTPasswordState {
  final ErrorMassegeModel errorMassegeModel;
  SendForgetPasswordOTPErros({required this.errorMassegeModel});
}

class SendForgetErrorState extends SendOtForgeTPasswordState {
  final String error;
  SendForgetErrorState({required this.error});
}

class ResetPasswordIsloadingState extends SendOtForgeTPasswordState {}

class ResetPasswordSuccesState extends SendOtForgeTPasswordState {
  final MessageModel messageModel;
  ResetPasswordSuccesState({required this.messageModel});
}

class ResetPasswordErrorState extends SendOtForgeTPasswordState {
  final String error;
  ResetPasswordErrorState({required this.error});
}

class ResetPasswordError extends SendOtForgeTPasswordState {
    final String error;
  ResetPasswordError({required this.error});
}
