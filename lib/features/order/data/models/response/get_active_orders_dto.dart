import 'package:manarat_amjad/features/order/domain/entities/orders_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_active_orders_dto.g.dart';

@JsonSerializable()
class GetActiveOrdersDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "orders")
  final List<ActiveOrder>? orders;

  GetActiveOrdersDto({this.message, this.orders});

  factory GetActiveOrdersDto.fromJson(Map<String, dynamic> json) {
    return _$GetActiveOrdersDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetActiveOrdersDtoToJson(this);
  }

  GetActiveOrdersEntity toGetActiveOrdersEntity() =>
      GetActiveOrdersEntity(message: message, orders: orders);
}

@JsonSerializable()
class ActiveOrder {
  @JsonKey(name: "order_number")
  final String? orderNumber;
  @JsonKey(name: "id_order")
  final int? idOrder;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "totalPrice")
  final double? totalPrice;
  @JsonKey(name: "order_date")
  final String? orderDate;
  @JsonKey(name: "delivery_time")
  final String? deliveryTime;
  @JsonKey(name: "is_active")
  final int? isActive;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "order_items")
  final List<OrderItems>? orderItems;

  ActiveOrder({
    this.orderNumber,
    this.idOrder,
    this.status,
    this.totalPrice,
    this.orderDate,
    this.deliveryTime,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.orderItems,
  });

  factory ActiveOrder.fromJson(Map<String, dynamic> json) {
    return _$ActiveOrderFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ActiveOrderToJson(this);
  }
}

@JsonSerializable()
class OrderItems {
  @JsonKey(name: "product_id")
  final int? productId;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "price")
  final num? price;
  @JsonKey(name: "priceAfterDiscount")
  final num? priceAfterDiscount;
  @JsonKey(name: "discount")
  final num? discount;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "totalPrice")
  final num? totalPrice;
  @JsonKey(name: "imgCover")
  final String? imgCover;

  OrderItems({
    this.productId,
    this.title,
    this.price,
    this.priceAfterDiscount,
    this.totalPrice,
    this.discount,
    this.quantity,
    this.imgCover,
  });

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return _$OrderItemsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderItemsToJson(this);
  }
}
