import 'package:objectbox/objectbox.dart';

@Entity()
class RecentEntity {
  @Id(assignable: true)
  int? id;
   @Unique()
  int uitId;
  String? tite;
  String? price;
  String? image;
  RecentEntity({this.tite, this.price, this.image,required this.uitId});
}
