import 'package:fada_alhalij_web/core/api/api_extentions.dart';
import 'package:fada_alhalij_web/core/api/api_manager/api_manager.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import 'package:fada_alhalij_web/core/utils/firebase_utils.dart';
import 'package:fada_alhalij_web/features/order/data/data_sources/orders_data_sources_repo.dart';
import 'package:fada_alhalij_web/features/order/data/models/request/add_order_request.dart';
import 'package:fada_alhalij_web/features/order/data/models/request/get_active_orders_request.dart';
import 'package:fada_alhalij_web/features/order/data/models/response/add_order_dto.dart';
import 'package:fada_alhalij_web/features/order/domain/entities/orders_entities.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersDataSourcesRepo)
class OrdersDataSourcesRepoImpl implements OrdersDataSourcesRepo {
  final ApiService apiService;

  OrdersDataSourcesRepoImpl(this.apiService);

  @override
  Future<Result<AddOrderEntity?>> addOrder(AddOrderRequest addOrderRequest) {
    return executeApi(() async {
      AddOrderDto? response = await apiService.addOrder(addOrderRequest);


      return response?.toAddOrderEntity();
    });
  }

  @override
  Future<Result<GetActiveOrdersEntity?>> getActiveOrders() {
    return executeApi(() async {
      int? userId = await CacheService.getData(key: CacheKeys.userId)??0;

      GetActiveOrdersRequest getActiveOrdersRequest = GetActiveOrdersRequest(userId: userId);
      var response = await apiService.getActiveOrders(getActiveOrdersRequest);
      return response?.toGetActiveOrdersEntity();
    });
  }

  @override
  Future<Result<GetActiveOrdersEntity?>> getCompletedOrder() {
   return executeApi(() async {
     int? userId = await CacheService.getData(key: CacheKeys.userId)??0;

     GetActiveOrdersRequest getActiveOrdersRequest = GetActiveOrdersRequest(userId: userId);
     var response = await apiService.getCompletedOrder(getActiveOrdersRequest);
     return response?.toGetActiveOrdersEntity();
   });
  }
}
