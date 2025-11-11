import 'package:manarat_amjad/features/order/domain/entities/orders_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_order_dto.g.dart';

@JsonSerializable()
class AddOrderDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "order_id")
  final int? orderId;
  @JsonKey(name: "order_number")
  final String? orderNumber;
  @JsonKey(name: "order_date")
  final String? orderDate;
  @JsonKey(name: "delivery_time")
  final String? deliveryTime;
  @JsonKey(name: "total_price")
  final int? totalPrice;
  @JsonKey(name: "orderItems")
  final List<OrderItems>? orderItems;

  AddOrderDto ({
    this.message,
    this.orderId,
    this.orderNumber,
    this.orderDate,
    this.deliveryTime,
    this.totalPrice,
    this.orderItems,
  });

  factory AddOrderDto.fromJson(Map<String, dynamic> json) {
    return _$AddOrderDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddOrderDtoToJson(this);
  }
  AddOrderEntity toAddOrderEntity() => AddOrderEntity(
    message: message,
    orderId: orderId,
    orderNumber: orderNumber,
    orderDate: orderDate,
    deliveryTime: deliveryTime,
    totalPrice: totalPrice,
    orderItems: orderItems,
  );
}

@JsonSerializable()
class OrderItems {
  @JsonKey(name: "order_id")
  final int? orderId;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "priceAfterDiscount")
  final int? priceAfterDiscount;
  @JsonKey(name: "discount")
  final int? discount;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "product")
  final Product? product;

  OrderItems ({
    this.orderId,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.totalPrice,
    this.quantity,
    this.product,
  });

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return _$OrderItemsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderItemsToJson(this);
  }
}

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "imgCover")
  final String? imgCover;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "priceAfterDiscount")
  final int? priceAfterDiscount;
  @JsonKey(name: "discount")
  final int? discount;
  @JsonKey(name: "category")
  final int? category;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  Product ({
    this.id,
    this.title,
    this.description,
    this.imgCover,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.category,
    this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductToJson(this);
  }
}


