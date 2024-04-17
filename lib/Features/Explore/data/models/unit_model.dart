import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';

class UnitMdel extends UnitEntity {
 const  UnitMdel(
      {required super.id,
      required super.title,
      required super.location,
      required super.unitCategoryName,
      required super.price,
      required super.image});
  factory UnitMdel.fromJson(Map<String, dynamic> json) {
    return UnitMdel(
        id: json['id'],
        title: json['title'],
        location: json['location'],
        unitCategoryName: json['unitCategoryName'],
        price: json['price'],
        image: json['image']);
  }
}
