import 'package:equatable/equatable.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_details_entity.dart';

class UnitByIDEntity extends Equatable {
  final UnitDetalisEntity unit;
  final bool isFaorite;
 const  UnitByIDEntity({
    required this.unit,
    required this.isFaorite,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
    unit,
    isFaorite,
  ];
}
class UnitById {
  Unit? unit;
  bool? isFaorite;

  UnitById({this.unit, this.isFaorite});

  UnitById.fromJson(Map<String, dynamic> json) {
    unit = json['unit'] != null ?  Unit.fromJson(json['unit']) : null;
    isFaorite = json['isFaorite'];
  }

}

class Unit {
  int? id;
  String? title;
  String? description;
  int? bedrooms;
  int? bathrooms;
  int? area;
  dynamic level;
  bool? isRent;
  bool? garage;
  bool? garden;
  String? dateBuilt;
  int? longitude;
  int? latitude;
  String? location;
  String? unitCategoryName;
  int? price;
  String? image;

  Unit(
      {this.id,
      this.title,
      this.description,
      this.bedrooms,
      this.bathrooms,
      this.area,
      this.level,
      this.isRent,
      this.garage,
      this.garden,
      this.dateBuilt,
      this.longitude,
      this.latitude,
      this.location,
      this.unitCategoryName,
      this.price,
      this.image});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    area = json['area'];
    level = json['level'];
    isRent = json['isRent'];
    garage = json['garage'];
    garden = json['garden'];
    dateBuilt = json['dateBuilt'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    location = json['location'];
    unitCategoryName = json['unitCategoryName'];
    price = json['price'];
    image = json['image'];
  }


}