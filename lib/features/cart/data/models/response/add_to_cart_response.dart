import 'package:manarat_amjad/features/cart/domain/entities/cart_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_response.g.dart';

@JsonSerializable()
class AddToCartResponseDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;

  AddToCartResponseDto ({
    this.status,
    this.message,
  });

  factory AddToCartResponseDto.fromJson(Map<String, dynamic> json) {
    return _$AddToCartResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddToCartResponseDtoToJson(this);
  }
  AddToCartEntity toAddToCartEntity ()=> AddToCartEntity(
    status: status,
    message: message,
  );
}


