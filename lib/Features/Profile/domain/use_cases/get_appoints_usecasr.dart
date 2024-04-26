import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Profile/domain/entities/user_appointments_entity.dart';
import 'package:realestate/Features/Profile/domain/repositories/get_appointments_repo.dart';
import 'package:realestate/core/error/failure.dart';

class GetAppointsUsecase {
  GetAppointmnetsRepo repo;
  GetAppointsUsecase({required this.repo});
  Future<Either<Failure,List<UserAppointment>>> call(String userId) async =>
      repo.getAppointments(userId);
}
