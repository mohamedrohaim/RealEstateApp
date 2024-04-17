import 'package:equatable/equatable.dart';

class UnitEntity extends Equatable{
 final  int id;
 final String title;
 final String location;
 final String unitCategoryName;
 final int price;
 final String image;
 const  UnitEntity({
    required this.id,
   required this.title,
  required  this.location,
   required this.unitCategoryName,
   required this.price,
   required this.image,
  });
  @override
  
  List<Object?> get props => [
    id,
    title,
    location,
    unitCategoryName,
    price,
    image
  ];

}