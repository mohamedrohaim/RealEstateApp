part of 'send_confirem_email_otp_cubit.dart';

sealed class SendConfiremEmailOtpState extends Equatable {
  const SendConfiremEmailOtpState();

  @override
  List<Object> get props => [];
}

final class SendConfiremEmailOtpInitial extends SendConfiremEmailOtpState {}

class SendConfirmEmailIsLoadingState extends SendConfiremEmailOtpState {}

class SendConfrimEmailErrorState extends SendConfiremEmailOtpState {
  final ErrorMassegeModel errorMassegeModel;
  const SendConfrimEmailErrorState({required this.errorMassegeModel});
}

class SendConfrimEmailSuccessState extends SendConfiremEmailOtpState {
  final LoginModel loginModel;
  const SendConfrimEmailSuccessState({required this.loginModel});
}

class SendErrorState extends SendConfiremEmailOtpState {
  final String error;
const   SendErrorState({required this.error});
}
