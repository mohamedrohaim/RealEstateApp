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
}
