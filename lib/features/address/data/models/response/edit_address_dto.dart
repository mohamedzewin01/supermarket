import 'package:manarat_amjad/features/address/domain/entities/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_address_dto.g.dart';

@JsonSerializable()
class EditAddressDto {
  @JsonKey(name: "status")
  final bool? status;
  @JsonKey(name: "message")
  final String? message;

  EditAddressDto ({
    this.status,
    this.message,
  });

  factory EditAddressDto.fromJson(Map<String, dynamic> json) {
    return _$EditAddressDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditAddressDtoToJson(this);
  }
  EditAddressEntity toEditAddressEntity() {
    return EditAddressEntity(
      status: status,
      message: message,
    );
  }
}


