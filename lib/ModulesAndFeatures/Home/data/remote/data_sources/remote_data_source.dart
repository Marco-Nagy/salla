import 'package:salla_shop_app/ModulesAndFeatures/Home/data/remote/models/product_model.dart';

abstract class BaseRemoteDataSource{
 Future<ProductModel> getProducts();
}
class RemoteDataSource implements BaseRemoteDataSource{
  @override
  Future<ProductModel> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

}