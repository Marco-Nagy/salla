import 'package:equatable/equatable.dart';
import 'package:salla_shop_app/models/model.dart';

class HomeModel extends Equatable {
  HomeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  HomeData data;

  factory HomeModel.fromMap(Map<String, dynamic> json) => HomeModel(
        status: json["status"] ?? false,
        message: json["message"] != null ? json["message"].toString() : '',
        data: json["data"] != null
            ? HomeData.fromMap(json["data"])
            : HomeData(banners: [], products: [], ad: ''),
      );

  @override
  List<Object?> get props => [status, message, data];
}

class HomeData extends Equatable {
  HomeData({
    required this.banners,
    required this.products,
    required this.ad,
  });

  List<Banner> banners;
  List<Product> products;
  String ad;

  factory HomeData.fromMap(Map<String, dynamic> json) => HomeData(
        banners: json["banners"] != null
            ? (json["banners"] as List).map((e) => Banner.fromMap(e)).toList()
            : [],
        products: json["products"] != null
            ? (json["products"] as List).map((x) => Product.fromMap(x)).toList()
            : [],
        ad: json["ad"] != null ? json["ad"].toString() : '',
      );

  @override
  List<Object?> get props => [products, banners, ad];
}
