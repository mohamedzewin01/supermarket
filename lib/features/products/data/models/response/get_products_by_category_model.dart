import 'package:fada_alhalij_web/features/products/domain/entities/products_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_products_by_category_model.g.dart';

@JsonSerializable()
class GetProductsByCategoryModel {
  @JsonKey(name: "productsData")
  final ProductsData? productsData;

  GetProductsByCategoryModel ({
    this.productsData,
  });

  factory GetProductsByCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$GetProductsByCategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetProductsByCategoryModelToJson(this);
  }
  GetProductsByCategoryEntity toProductsModelEntity() =>
      GetProductsByCategoryEntity(productsData: productsData);
}

@JsonSerializable()
class ProductsData {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "page")
  final int? page;
  @JsonKey(name: "perPage")
  final int? perPage;
  @JsonKey(name: "totalItems")
  final int? totalItems;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "productsRelations")
  final List<ProductsRelations>? productsRelations;

  ProductsData ({
    this.status,
    this.page,
    this.perPage,
    this.totalItems,
    this.totalPages,
    this.productsRelations,
  });

  factory ProductsData.fromJson(Map<String, dynamic> json) {
    return _$ProductsDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsDataToJson(this);
  }
}

@JsonSerializable()
class ProductsRelations {
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

  ProductsRelations ({
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

  factory ProductsRelations.fromJson(Map<String, dynamic> json) {
    return _$ProductsRelationsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsRelationsToJson(this);
  }
}


