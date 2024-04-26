part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class GetAppointmentsIsloading extends ProfileState {}

class GetAppointmentIsSucces extends ProfileState {
  List<UserAppointment> appointmnets;
  GetAppointmentIsSucces({required this.appointmnets});
}

class GetAppointmentIsError extends ProfileState {
  final String error;
  GetAppointmentIsError({required this.error});
}
