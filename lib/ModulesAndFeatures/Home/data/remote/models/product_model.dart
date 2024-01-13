
import 'package:salla_shop_app/ModulesAndFeatures/Home/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {required int id,
      required double price,
      required double oldPrice,
      required int discount,
      required String image,
      required String name,
      required String description,
      required List<String> images,
      required bool inFavorites,
      required bool inCart})
      : super(
            id: id,
            price: price,
            oldPrice: oldPrice,
            discount: discount,
            image: image,
            name: name,
            description: description,
            images: images,
            inFavorites: inFavorites,
            inCart: inCart);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      price: json["price"].toDouble(),
      oldPrice: json["old_price"].toDouble(),
      discount: json["discount"],
      image: json["image"],
      name: json["name"],
      description: json["description"],
      images:json["images"]!= null?(json["images"] as List).map((e) => e.toString()).toList():[],
      inFavorites: json["in_favorites"],
      inCart: json["in_cart"],
    );
  }
}
