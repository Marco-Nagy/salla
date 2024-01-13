import 'package:salla_shop_app/ModulesAndFeatures/Home/domain/entities/product.dart';
import 'package:salla_shop_app/ModulesAndFeatures/Home/domain/repositories/home_repository.dart';

/// ? this class is a Bridge to Presentation Layer
class GetProductsList {
  final BaseHomeRepository productRepository;

  const GetProductsList(
    this.productRepository,
  );
 Future<List<Product>> execute()async{
    return await productRepository.getProductsList();
  }
}
