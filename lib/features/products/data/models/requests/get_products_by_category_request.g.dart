// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_by_category_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductsByCategoryRequest _$GetProductsByCategoryRequestFromJson(
  Map<String, dynamic> json,
) => GetProductsByCategoryRequest(
  idCategory: (json['idCategory'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
  perPage: (json['perPage'] as num?)?.toInt(),
);

Map<String, dynamic> _$GetProductsByCategoryRequestToJson(
  GetProductsByCategoryRequest instance,
) => <String, dynamic>{
  'idCategory': instance.idCategory,
  'page': instance.page,
  'perPage': instance.perPage,
};
