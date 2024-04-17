import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';
import 'package:realestate/Features/Favorites/domain/repositories/get_favoirt_repo.dart';
import 'package:realestate/core/error/failure.dart';

class GetFavoritUsecse {
 final GetFavoirtRepo getFavoirtRepo;
  GetFavoritUsecse({required this.getFavoirtRepo});
  Future<Either<Failure,List<UnitEntity>>>call(String userId)async=>getFavoirtRepo.getFavoirt(userId);
}
