

import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/products/data/data_sources/products_data_source.dart';
import 'package:manarat_amjad/features/products/domain/entities/products_entities.dart';
import 'package:manarat_amjad/features/products/domain/repo/products_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepo)
class ProductsRepoImpl implements ProductsRepo {
  ProductsDataSource productsDataSourceRepo;

  ProductsRepoImpl(this.productsDataSourceRepo);


  @override
  Future<Result<GetProductsByCategoryEntity?>> getProducts( String idCategory, {
   required int page ,
    required int limit,
  }) {
  return productsDataSourceRepo.getProductsData(idCategory, page: page, limit: limit);
  }
}
