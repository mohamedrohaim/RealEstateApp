import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Explore/data/data_sources/remote_data_source.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_by_id.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';
import 'package:realestate/Features/Explore/domain/repositories/get_unit_repo.dart';
import 'package:realestate/core/error/failure.dart';

class GetUnitRepoImpl implements GetUnitRepo {
  final RemoteDataSource remoteDataSource;
  GetUnitRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<UnitEntity>>> getUnit() async {
    try {
      final unit = await remoteDataSource.getUnit();
      log("repo imp" + unit.toString());
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UnitById>> getUnitByID(int id, String userId) async {
    try {
      var unitById = await remoteDataSource.getUnitById(id, userId);
      log("repo impl" + unitById.toString());
      return Right(unitById);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> adToFavorit(int id, String userId) async {
    try {
      final response = await remoteDataSource.addTofavoirt(id, userId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<String, String>> addAppointment(
      String scheduleDate,
      int unitId,
      String userId,
      String whatsappnumber,
      String email,
      bool isApproved) async {
    try {
      final response = await remoteDataSource.addAppointment(
          scheduleDate, unitId, userId, whatsappnumber, email, isApproved);
      return Right(response);
    } catch (error) {
      return Left(error.toString());
    }
  }
    @override
  Future<Either<Failure, List<UnitEntity>?>> searchFilter(String? title,String? governate, int? priceFrom, int? priceTo) async{
    try {
      final response = await remoteDataSource.searchFilter(title, governate, priceFrom, priceTo);
      log("repo impl" + response.toString());
      return Right(response);
    } catch (error) {
      return Left(ServerFailure());
    }
  }
}
