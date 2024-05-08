import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';
import 'package:realestate/Features/Explore/domain/repositories/get_unit_repo.dart';
import 'package:realestate/core/error/failure.dart';

class FilterSearchUsCase {
  final GetUnitRepo getUnitRepo;
  FilterSearchUsCase({required this.getUnitRepo});
  Future<Either<Failure, List<UnitEntity>?>> call(String? title,String? governate, int? priceFrom, int? priceTo)async=>getUnitRepo.searchFilter(title, governate, priceFrom, priceTo);
}
