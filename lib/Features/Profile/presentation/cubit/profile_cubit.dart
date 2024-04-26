import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Explore/domain/entities/recent_entity.dart';
import 'package:realestate/Features/Profile/domain/entities/user_appointments_entity.dart';
import 'package:realestate/Features/Profile/domain/use_cases/get_appoints_usecasr.dart';
import 'package:realestate/core/error/failure.dart';
import 'package:realestate/core/helper/objectbox_interface.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.getAppointsUsecase}) : super(ProfileInitial());
  GetAppointsUsecase getAppointsUsecase;
  Future<void> getAppointment(String userID) async {
    emit(GetAppointmentsIsloading());
    try {
      Either<Failure, List<UserAppointment>> appointments =
          await getAppointsUsecase.call(userID);
      emit(appointments.fold(
          (l) => GetAppointmentIsError(error: _mapFailureToMsg(l)),
          (r) => GetAppointmentIsSucces(appointmnets: r)));
    } catch (error) {
      emit(GetAppointmentIsError(error: error.toString()));
    }
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ServerFailure";
      case CacheFailure:
        return "CacheFailure";
      default:
        return "unexpectedError";
    }
  }
}
