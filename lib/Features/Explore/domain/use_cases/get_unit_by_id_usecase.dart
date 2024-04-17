import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_by_id.dart';
import 'package:realestate/Features/Explore/domain/repositories/get_unit_repo.dart';
import 'package:realestate/core/error/failure.dart';

class GetUnitByIdUseCase {
  final GetUnitRepo getUnitRepo;
  GetUnitByIdUseCase({required this.getUnitRepo});
  Future<Either<Failure, UnitById>> call(int id,String userId) async =>
      getUnitRepo.getUnitByID(id,userId);
}
