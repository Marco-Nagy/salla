/// status : true
/// message : "تمت الإضافة بنجاح"
/// data : {"id":36084,"product":{"id":52,"price":25000,"old_price":25000,"discount":0,"image":"https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg"}}

class FavoriteChangeResponse {
  FavoriteChangeResponse({
      bool? status, 
      String? message, 
      FavoritesData? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  FavoriteChangeResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? FavoritesData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  FavoritesData? _data;

  bool? get status => _status;
  String? get message => _message;
  FavoritesData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 36084
/// product : {"id":52,"price":25000,"old_price":25000,"discount":0,"image":"https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg"}

class FavoritesData {
  FavoritesData({
      int? id,
      Product? product,}){
    _id = id;
    _product = product;
}

  FavoritesData.fromJson(dynamic json) {
    _id = json['id'];
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  int? _id;
  Product? _product;

  int? get id => _id;
  Product? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }

}

/// id : 52
/// price : 25000
/// old_price : 25000
/// discount : 0
/// image : "https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg"

class Product {
  Product({
      int? id,
      int? price,
      int? oldPrice,
      int? discount,
      String? image,}){
    _id = id;
    _price = price;
    _oldPrice = oldPrice;
    _discount = discount;
    _image = image;
}

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _oldPrice = json['old_price'];
    _discount = json['discount'];
    _image = json['image'];
  }
  int? _id;
  dynamic? _price;
  dynamic? _oldPrice;
  int? _discount;
  String? _image;

  int? get id => _id;
  dynamic? get price => _price;
  dynamic? get oldPrice => _oldPrice;
  int? get discount => _discount;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['old_price'] = _oldPrice;
    map['discount'] = _discount;
    map['image'] = _image;
    return map;
  }

}