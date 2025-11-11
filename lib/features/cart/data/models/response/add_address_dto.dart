import 'package:manarat_amjad/features/cart/domain/entities/cart_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_address_dto.g.dart';

@JsonSerializable()
class AddAddressDto {
  @JsonKey(name: "status")
  final bool? status;
  @JsonKey(name: "message")
  final String? message;

  AddAddressDto ({
    this.status,
    this.message,
  });

  factory AddAddressDto.fromJson(Map<String, dynamic> json) {
    return _$AddAddressDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddAddressDtoToJson(this);
  }
  AddAddressUserEntity toAddAddressUserEntity() => AddAddressUserEntity(
    status: status,
    message: message,
  );
}


