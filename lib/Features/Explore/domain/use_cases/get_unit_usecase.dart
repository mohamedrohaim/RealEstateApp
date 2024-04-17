// import 'package:dartz/dartz.dart';
// import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';
// import 'package:realestate/Features/Explore/domain/entities/unit_list_entity.dart';
// import 'package:realestate/Features/Explore/domain/repositories/get_unit_repo.dart';
// import 'package:realestate/core/error/failure.dart';
// import 'package:realestate/core/usecase/usecase.dart';

// class GetUnitUseCase extends UseCase<List<UnitEntity>, NoParmas> {
//   GetUnitRepo getUnitRepo;
//   GetUnitUseCase({required this.getUnitRepo});
//   @override
//   Future<Either<Failure,List<UnitEntity>>> call(NoParmas parmas) async =>
//       getUnitRepo.getUnit();
// }
import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_by_id.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';
import 'package:realestate/Features/Explore/domain/repositories/get_unit_repo.dart';
import 'package:realestate/core/error/failure.dart';

class GetUnitUseCase {
  GetUnitRepo getUnitRepo;
  GetUnitUseCase({required this.getUnitRepo});
  Future<Either<Failure, List<UnitEntity>>> call() async =>
      getUnitRepo.getUnit();
}

