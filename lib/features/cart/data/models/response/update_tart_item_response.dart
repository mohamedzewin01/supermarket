import 'package:manarat_amjad/features/cart/domain/entities/cart_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_tart_item_response.g.dart';

@JsonSerializable()
class UpdateCartItemResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "product_id")
  final int? productId;
  @JsonKey(name: "quantity")
  final int? quantity;

  UpdateCartItemResponseDto ({
    this.message,
    this.userId,
    this.productId,
    this.quantity,
  });

  factory UpdateCartItemResponseDto.fromJson(Map<String, dynamic> json) {
    return _$UpdateCartItemResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateCartItemResponseDtoToJson(this);
  }
  UpdateCartItemEntity toUpdateCartItemEntity() {
    return UpdateCartItemEntity(
      message: message,

      quantity: quantity,
    );
  }
}


