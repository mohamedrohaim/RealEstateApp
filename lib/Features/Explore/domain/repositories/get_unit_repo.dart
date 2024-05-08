import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_by_id.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';
import 'package:realestate/core/error/failure.dart';

abstract class GetUnitRepo {
  Future<Either<Failure, List<UnitEntity>>> getUnit();
  Future<Either<Failure, UnitById>> getUnitByID(int id, String userId);
  Future<Either<Failure, String>> adToFavorit(int id, String userId);
  Future<Either<String, String>> addAppointment(
        String scheduleDate,
    int unitId,
    String userId,
    String whatsappnumber,
    String email,
    bool isApproved
  );
    Future<Either<Failure, List<UnitEntity>?>> searchFilter(String? title,String? governate, int? priceFrom, int? priceTo);
}
