import 'package:salla_shop_app/ModulesAndFeatures/Home/domain/entities/banner.dart';

class BannerModel extends Banner {
  BannerModel({
    required int id,
    required String image,
    required category,
    required product,
  }) : super(
    id: id,
    image: image,
    category: category,
    product: product,
  );

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      image: json['image']!= null?json['image'].toString():'',
      category: json['category']??'',
      product: json['product']??'',
    );
  }


}
