

import 'package:manarat_amjad/features/order/data/models/response/add_order_dto.dart';
import 'package:manarat_amjad/features/order/data/models/response/get_active_orders_dto.dart' hide OrderItems;

class AddOrderEntity {


  final String? message;

  final int? orderId;

  final String? orderNumber;

  final String? orderDate;

  final String? deliveryTime;

  final int? totalPrice;

  final List<OrderItems>? orderItems;

  AddOrderEntity ({
    this.message,
    this.orderId,
    this.orderNumber,
    this.orderDate,
    this.deliveryTime,
    this.totalPrice,
    this.orderItems,
  });


}

class GetActiveOrdersEntity {

  final String? message;

  final List<ActiveOrder>? orders;

  GetActiveOrdersEntity ({
    this.message,
    this.orders,
  });


}