import 'package:fada_alhalij_web/core/api/api_extentions.dart';
import 'package:fada_alhalij_web/core/api/api_manager/api_manager.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/features/products/data/models/requests/get_products_by_category_request.dart';
import 'package:fada_alhalij_web/features/products/domain/entities/products_entities.dart';
import 'package:injectable/injectable.dart';



@injectable
class ProductsDataSource  {
  ApiService apiService;

  ProductsDataSource(this.apiService);

  Future<Result<GetProductsByCategoryEntity?>> getProductsData(String idCategory,int page,int perPage) {
    return executeApi(() async {
      GetProductsByCategoryRequest productsByCategoryRequest = GetProductsByCategoryRequest(idCategory:int.parse(idCategory),page: page,perPage: perPage);
      var response = await apiService.getProductsByCategory(productsByCategoryRequest);
      return response?.toProductsModelEntity();
    });
  }
}
