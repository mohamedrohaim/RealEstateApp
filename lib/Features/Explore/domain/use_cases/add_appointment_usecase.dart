import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Explore/domain/repositories/get_unit_repo.dart';

class AddAppointmentUseCase {
  final GetUnitRepo repo;
  AddAppointmentUseCase({required this.repo});
  Future<Either <String ,String>>call(
    String scheduleDate,
    int unitId,
    String userId,
    String whatsappnumber,
    String email,
    bool isApproved
  )async=>repo.addAppointment(scheduleDate, unitId, userId, whatsappnumber, email, isApproved);
}
