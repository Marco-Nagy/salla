
// ! Dependency Injection Principal
// * High Level Modules Should not depends on low Level Modules
// * Both (high and low level modules) must depends on Abstract class to link each other

import 'package:flutter/cupertino.dart';
import 'package:salla_shop_app/ModulesAndFeatures/Home/domain/entities/product.dart';

abstract class BaseHomeRepository{
 Future<List<Product>>getProductsList();
 Future<List<Banner>>getBannersList();
}