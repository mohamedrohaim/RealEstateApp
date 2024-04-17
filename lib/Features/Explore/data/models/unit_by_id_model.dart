import 'package:realestate/Features/Explore/data/models/unit_details_model.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_by_id.dart';

class UnitByIdModel extends UnitByIDEntity {
  UnitByIdModel({required super.unit, required super.isFaorite});
  factory UnitByIdModel.fromJson(Map<String, dynamic> json) {
    return UnitByIdModel(
        unit:UnitDetailsModel.fromJson(json['unit']), isFaorite: json['isFaorite']);
  }
}
