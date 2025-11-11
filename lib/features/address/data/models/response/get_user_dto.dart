import 'package:manarat_amjad/features/address/domain/entities/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_user_dto.g.dart';

@JsonSerializable()
class GetUserAddressesDto {
  @JsonKey(name: "status")
  final bool? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final List<DataAddresses>? data;

  GetUserAddressesDto({this.status, this.message, this.data});

  factory GetUserAddressesDto.fromJson(Map<String, dynamic> json) {
    return _$GetUserAddressesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetUserAddressesDtoToJson(this);
  }

  GetUserAddressEntity toGetUserAddressEntity() => GetUserAddressEntity(
    status: status,
    message: message,
    data: data,
  ); //GetUserAddressEntity
}

@JsonSerializable()
class DataAddresses {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;
  @JsonKey(name: "details")
  final String? details;
  @JsonKey(name: "delivery_area_id")
  final int? deliveryAreaId;
  @JsonKey(name: "created_at")
  final String? createdAt;

  DataAddresses({
    this.id,
    this.userId,
    this.title,
    this.street,
    this.city,
    this.lat,
    this.long,
    this.details,
    this.deliveryAreaId,
    this.createdAt,
  });

  factory DataAddresses.fromJson(Map<String, dynamic> json) {
    return _$DataAddressesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataAddressesToJson(this);
  }
}
