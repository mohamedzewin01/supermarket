

import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/features/products/data/data_sources/products_data_source.dart';
import 'package:fada_alhalij_web/features/products/domain/entities/products_entities.dart';
import 'package:fada_alhalij_web/features/products/domain/repo/products_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepo)
class ProductsRepoImpl implements ProductsRepo {
  ProductsDataSource productsDataSourceRepo;

  ProductsRepoImpl(this.productsDataSourceRepo);


  @override
  Future<Result<ProductsModelEntity?>> getProducts(String idCategory,int page,int perPage) {
  return productsDataSourceRepo.getProductsData(idCategory, page, perPage);
  }
}
