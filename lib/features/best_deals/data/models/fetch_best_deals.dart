import 'package:manarat_amjad/features/best_deals/domain/entities/best_deals_by_categories_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fetch_best_deals.g.dart';

@JsonSerializable()
class FetchBestDeals {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "bestDeals")
  final List<AllBestDeals>? bestDeals;

  FetchBestDeals ({
    this.status,
    this.bestDeals,
  });

  factory FetchBestDeals.fromJson(Map<String, dynamic> json) {
    return _$FetchBestDealsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$FetchBestDealsToJson(this);
  }
  FetchBestDealsEntity toFetchBestDealsEntity() {
    return FetchBestDealsEntity(
      status: status,
      bestDeals: bestDeals,
    );
  }
}

@JsonSerializable()
class AllBestDeals {
  @JsonKey(name: "id_product")
  final int? idProduct;
  @JsonKey(name: "product_name")
  final String? productName;
  @JsonKey(name: "product_price")
  final double? productPrice;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "image_cover")
  final String? imageCover;
  @JsonKey(name: "product_price_after_discount")
  final double? productPriceAfterDiscount;
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

  AllBestDeals ({
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

  factory AllBestDeals.fromJson(Map<String, dynamic> json) {
    return _$AllBestDealsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllBestDealsToJson(this);
  }
}


