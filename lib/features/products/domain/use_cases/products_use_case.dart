import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/features/home/domain/entities/home_entities.dart';
import 'package:fada_alhalij_web/features/home/domain/repo/home_repo.dart';
import 'package:fada_alhalij_web/features/products/domain/entities/products_entities.dart';
import 'package:fada_alhalij_web/features/products/domain/repo/products_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsUseCase {
  ProductsRepo productsRepo;

  ProductsUseCase(this.productsRepo);

  Future<Result<GetProductsByCategoryEntity?>> getHomeData( String idCategory, {
    required int page,
   required int limit ,
  }) {
    return productsRepo.getProducts(idCategory, page: page, limit: limit);
  }
}
