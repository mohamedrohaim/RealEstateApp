import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Explore/domain/repositories/get_unit_repo.dart';
import 'package:realestate/core/error/failure.dart';

class AddToFavoritUsecase {
  GetUnitRepo getUnitRepo;
  AddToFavoritUsecase({required this.getUnitRepo});
  Future<Either<Failure, String>> call(int id, String userId) async =>
      getUnitRepo.adToFavorit(id, userId);
}
