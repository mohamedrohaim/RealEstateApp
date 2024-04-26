import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Profile/domain/entities/user_appointments_entity.dart';
import 'package:realestate/core/error/failure.dart';

abstract class GetAppointmnetsRepo{
  Future<Either<Failure,List<UserAppointment>>>getAppointments(String useId);
}