import 'package:realestate/Features/Explore/domain/entities/unit_details_entity.dart';

class UnitDetailsModel extends UnitDetalisEntity {
  UnitDetailsModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.bedrooms,
      required super.bathrooms,
      required super.area,
      required super.level,
      required super.isRent,
      required super.garage,
      required super.garden,
      required super.dateBuilt,
      required super.longitude,
      required super.latitude,
      required super.location,
      required super.unitCategoryName,
      required super.price,
      required super.image});
  factory UnitDetailsModel.fromJson(Map<String, dynamic> json) {
    return UnitDetailsModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        bedrooms: json['bedrooms'],
        bathrooms: json['bathrooms'],
        area: json['area'],
        level: json['level'],
        isRent: json['isRent'],
        garage: json['garage'],
        garden: json['garden'],
        dateBuilt: json['dateBuilt'],
        longitude: json['longitude'],
        latitude: json['latitude'],
        location: json['location'],
        unitCategoryName:json ['unitCategoryName'],
        price: json['price'],
        image: json['image']);
  }
}
