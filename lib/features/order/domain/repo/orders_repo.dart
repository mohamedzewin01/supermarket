


import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/order/data/models/request/add_order_request.dart';
import 'package:manarat_amjad/features/order/domain/entities/orders_entities.dart';

abstract class OrdersRepo {
  Future<Result<AddOrderEntity?>> addOrder(AddOrderRequest addOrderRequest);
  Future<Result<GetActiveOrdersEntity?>> getActiveOrders();
  Future<Result<GetActiveOrdersEntity?>> getCompletedOrder();
}