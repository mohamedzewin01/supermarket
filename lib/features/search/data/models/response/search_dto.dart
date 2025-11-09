
import 'package:fada_alhalij_web/features/search/domain/entities/search_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
part 'search_dto.g.dart';

@JsonSerializable()
class SearchDto {
  @JsonKey(name: "status")
  final bool? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "total_count")
  final int? totalCount;
  @JsonKey(name: "page")
  final int? page;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "data")
  final List<DataSearch>? data;

  SearchDto ({
    this.status,
    this.message,
    this.totalCount,
    this.page,
    this.limit,
    this.data,
  });

  factory SearchDto.fromJson(Map<String, dynamic> json) {
    return _$SearchDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SearchDtoToJson(this);
  }
  SearchEntity toSearchEntity() {
    return SearchEntity(
      status: status,
      message: message,
      totalCount: totalCount,
      page: page,
      limit: limit,
      data: data,
    );
  }
}

@JsonSerializable()
class DataSearch {
  @JsonKey(name: "id_product")
  final int? idProduct;
  @JsonKey(name: "product_name")
  final String? productName;
  @JsonKey(name: "product_price")
  final num? productPrice;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "image_cover")
  final String? imageCover;
  @JsonKey(name: "product_price_after_discount")
  final num? productPriceAfterDiscount;
  @JsonKey(name: "category")
  final int? category;
  @JsonKey(name: "descount")
  final int? descount;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "date_descount")
  final String? dateDescount;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "category_id")
  final int? categoryId;
  @JsonKey(name: "category_name")
  final String? categoryName;
  @JsonKey(name: "category_image")
  final String? categoryImage;
  @JsonKey(name: "category_status")
  final int? categoryStatus;
  @JsonKey(name: "category_creatAt")
  final String? categoryCreatAt;

  DataSearch ({
    this.idProduct,
    this.productName,
    this.productPrice,
    this.description,
    this.imageCover,
    this.productPriceAfterDiscount,
    this.category,
    this.descount,
    this.status,
    this.dateDescount,
    this.createdAt,
    this.categoryId,
    this.categoryName,
    this.categoryImage,
    this.categoryStatus,
    this.categoryCreatAt,
  });

  factory DataSearch.fromJson(Map<String, dynamic> json) {
    return _$DataSearchFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataSearchToJson(this);
  }

  ProductsRelations toProductsRelations() {
    return ProductsRelations(
      idProduct: idProduct,
      productName: productName,
      productPrice: productPrice,
      description: description,
      imageCover: imageCover,
      productPriceAfterDiscount: productPriceAfterDiscount,
      category: category,
      descount: descount,
      status: status,
      dateDescount: dateDescount,
      createdAt: createdAt,
      categoryId: categoryId,
      categoryName: categoryName,
      categoryImage: categoryImage,
      categoryStatus: categoryStatus,
      categoryCreatAt: categoryCreatAt,
    );
  }
}


