import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';

class UnitsGroupedByCategory {
  final String category;
  final List<UnitEntity> units;

  UnitsGroupedByCategory({
    required this.category,
    required this.units,
  });
}