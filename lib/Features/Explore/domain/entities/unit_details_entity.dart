import 'package:equatable/equatable.dart';

class UnitDetalisEntity extends Equatable {
  final  int id;
  final String title;
final  String description;
 final int bedrooms;
 final int bathrooms;
final  int area;
final dynamic level;
final  bool isRent;
 final bool garage;
final  bool garden;
 final String dateBuilt;
 final int longitude;
 final int latitude;
 final String location;
 final String unitCategoryName;
 final int price;
 final String image;
 const UnitDetalisEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.level,
    required this.isRent,
    required this.garage,
    required this.garden,
    required this.dateBuilt,
    required this.longitude,
    required this.latitude,
    required this.location,
    required this.unitCategoryName,
    required this.price,
    required this.image,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
     id,
   title,
   description,
   bedrooms,
   bathrooms,
  area,
  level,
   isRent,
   garage,
   garden,
   dateBuilt,
   longitude,
   latitude,
  location,
  unitCategoryName,
 price,
  image,
  ];
}
