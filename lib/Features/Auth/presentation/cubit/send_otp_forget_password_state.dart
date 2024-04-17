part of 'send_otp_forget_password_cubit.dart';

sealed class SendOtpForgetPasswordState extends Equatable {
  const SendOtpForgetPasswordState();

  @override
  List<Object> get props => [];
}

final class SendOtpResetPasswordInitial extends SendOtpForgetPasswordState {}

class SendOTPForgetPasswordLoadingState extends SendOtpForgetPasswordState {}

class SendOTPForgetPasswordSuccesState extends SendOtpForgetPasswordState {
  final MessageModel message;
  const SendOTPForgetPasswordSuccesState({required this.message});
}

class SendOTPForegtPasswordErrorState extends SendOtpForgetPasswordState {
  final ErrorMassegeModel errorMassegeModel;
  SendOTPForegtPasswordErrorState({required this.errorMassegeModel});
}

class SendOTPErrorState extends SendOtpForgetPasswordState {
  final String error;
 const SendOTPErrorState({required this.error});
}

class ShowCustomDialogState extends SendOtpForgetPasswordState {}
