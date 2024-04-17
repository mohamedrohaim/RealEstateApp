import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';
import 'package:realestate/Features/Favorites/data/data_sources/get_favoirt_remote_data.dart';
import 'package:realestate/Features/Favorites/domain/repositories/get_favoirt_repo.dart';
import 'package:realestate/core/error/failure.dart';

class GetFavoirtsImpl implements GetFavoirtRepo {
  final GetFavoritRemoteData remoteData;
  GetFavoirtsImpl({required this.remoteData});
  @override
  Future<Either<Failure, List<UnitEntity>>> getFavoirt(String userId) async {
    try {
      final favorits = await remoteData.getFavoirt(userId);
      return Right(favorits);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> removeFromFavoritList(
      String userId, int id) async {
    try {
      var response = await remoteData.removeFromFavoirtList(userId, id);
      log(response.toString());
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
