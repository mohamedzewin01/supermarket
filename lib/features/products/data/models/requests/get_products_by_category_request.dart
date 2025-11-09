import 'package:json_annotation/json_annotation.dart';

part 'get_products_by_category_request.g.dart';

@JsonSerializable()
class GetProductsByCategoryRequest {
  @JsonKey(name: "idCategory")
  final int? idCategory;
  @JsonKey(name: "page")
  final int? page;
  @JsonKey(name: "perPage")
  final int? perPage;

  GetProductsByCategoryRequest ({
    this.idCategory,
    this.page,
    this.perPage,
  });

  factory GetProductsByCategoryRequest.fromJson(Map<String, dynamic> json) {
    return _$GetProductsByCategoryRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetProductsByCategoryRequestToJson(this);
  }
}


