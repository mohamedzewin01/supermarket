import 'package:manarat_amjad/features/cart/domain/entities/cart_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'del_item_cart_dto.g.dart';

@JsonSerializable()
class DelItemCartDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;

  DelItemCartDto ({
    this.status,
    this.message,
  });

  factory DelItemCartDto.fromJson(Map<String, dynamic> json) {
    return _$DelItemCartDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DelItemCartDtoToJson(this);
  }
  DelItemCartEntity toDelItemCartEntity() {
    return DelItemCartEntity(
      status: status,
      message: message,
    );
  }
}


