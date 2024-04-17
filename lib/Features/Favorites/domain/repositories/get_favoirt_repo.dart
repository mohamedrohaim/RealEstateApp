import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';
import 'package:realestate/core/error/failure.dart';

abstract class GetFavoirtRepo {
  Future<Either<Failure, List<UnitEntity>>> getFavoirt(String userId);
   Future<Either<Failure, String>> removeFromFavoritList(String userId,int id);
}
