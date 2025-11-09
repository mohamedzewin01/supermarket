import 'package:fada_alhalij_web/core/api/api_extentions.dart';
import 'package:fada_alhalij_web/core/api/api_manager/api_manager.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/features/products/data/models/requests/get_products_by_category_request.dart';
import 'package:fada_alhalij_web/features/products/domain/entities/products_entities.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsDataSource {
  ApiService apiService;

  ProductsDataSource(this.apiService);

  Future<Result<GetProductsByCategoryEntity?>> getProductsData(
      String idCategory, {
        int page = 1,
        int limit = 20,
      }) {
    return executeApi(() async {
      var response = await apiService.getProductsByCategory(
        GetProductsByCategoryRequest(page: page,perPage: limit,idCategory: int.parse(idCategory))

      );
      return response?.toProductsModelEntity();
    });
  }
}