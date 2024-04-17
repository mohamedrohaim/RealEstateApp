import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Favorites/domain/repositories/get_favoirt_repo.dart';
import 'package:realestate/core/error/failure.dart';

class RemoveFromFavoritListUsecase {
  final GetFavoirtRepo getFavoirtRepo;
  RemoveFromFavoritListUsecase({required this.getFavoirtRepo});
  Future<Either<Failure,String>>call(String userId,int id)async=>getFavoirtRepo.removeFromFavoritList(userId, id);
}
