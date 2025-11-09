import 'package:fada_alhalij_web/features/products/domain/entities/products_entities.dart';

import '../../../../core/common/api_result.dart';


abstract class ProductsRepo {
  Future<Result<ProductsModelEntity?>> getProducts(String idCategory,int page,int perPage);
}
