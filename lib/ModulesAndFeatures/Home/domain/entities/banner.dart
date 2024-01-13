import 'package:equatable/equatable.dart';

class Banner extends Equatable{
  Banner({
    required this.id,
    required this.image,
    required this.category,
    required this.product,
  });

  int id;
  String image;
  dynamic category;
  dynamic product;

  @override
  // TODO: implement props
  List<Object?> get props => [id,image,category,product];
}