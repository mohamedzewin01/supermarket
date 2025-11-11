import 'package:manarat_amjad/features/address/domain/entities/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_delivery_areas_dto.g.dart';

@JsonSerializable()
@JsonSerializable()
class GetDeliveryAreasDto {
  @JsonKey(name: "status")
  final bool? status;

  @JsonKey(name: "data")
  final List<DataAreas>? dataAreas;

  GetDeliveryAreasDto({
    this.status,
    this.dataAreas,
  });

  factory GetDeliveryAreasDto.fromJson(Map<String, dynamic> json) =>
      _$GetDeliveryAreasDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetDeliveryAreasDtoToJson(this);

  DeliveryAreasEntity? toDeliveryAreasEntity() {
    return DeliveryAreasEntity(
      status: status,
      dataAreas: dataAreas,
    );
  }
}


@JsonSerializable()
class DataAreas {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "area_name")
  final String? areaName;
  @JsonKey(name: "delivery_cost")
  final String? deliveryCost;
  @JsonKey(name: "delivery_time")
  final String? deliveryTime;
  @JsonKey(name: "minimum_order_value")
  final String? minimumOrderValue;
  @JsonKey(name: "latitude")
  final String? latitude;
  @JsonKey(name: "longitude")
  final String? longitude;
  @JsonKey(name: "additional_fees")
  final String? additionalFees;
  @JsonKey(name: "is_active")
  final int? isActive;
  @JsonKey(name: "notes")
  final String? notes;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "payment_methods")
  final String? paymentMethods;

  DataAreas ({
    this.id,
    this.areaName,
    this.deliveryCost,
    this.deliveryTime,
    this.minimumOrderValue,
    this.latitude,
    this.longitude,
    this.additionalFees,
    this.isActive,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.paymentMethods,
  });

  factory DataAreas.fromJson(Map<String, dynamic> json) {
    return _$DataAreasFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataAreasToJson(this);
  }
}


