import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Profile/data/data_sources/profile_remote_data.dart';
import 'package:realestate/Features/Profile/domain/entities/user_appointments_entity.dart';
import 'package:realestate/Features/Profile/domain/repositories/get_appointments_repo.dart';
import 'package:realestate/core/error/failure.dart';

class GetAppointmentRepoImpl implements GetAppointmnetsRepo {
  ProfileRmoeteData remoteData;
  GetAppointmentRepoImpl({required this.remoteData});
  @override
  Future<Either<Failure, List<UserAppointment>>> getAppointments(
      String useId) async {
    try {
      final response = await remoteData.getAppointments(useId);
      return Right(response);
    } catch (error) {
      return Left(ServerFailure());
    }
  }
}
