import 'package:fada_alhalij_web/features/home/domain/entities/home_entities.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
part 'home_model_response_dto.g.dart';

@JsonSerializable()
class HomeModelResponseDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "data")
  final Data? data;

  HomeModelResponseDto ({
    this.status,
    this.data,
  });

  factory HomeModelResponseDto.fromJson(Map<String, dynamic> json) {
    return _$HomeModelResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HomeModelResponseDtoToJson(this);
  }
  HomeEntity toHomeEntity() => HomeEntity(data: data ,status: status);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "store")
  final Store? store;
  @JsonKey(name: "discount")
  final Discount? discount;
  @JsonKey(name: "banner")
  final Banner? banner;
  @JsonKey(name: "category")
  final Category? category;
  @JsonKey(name: "bestDeals")
  final BestDeals? bestDeals;

  Data ({
    this.status,
    this.store,
    this.discount,
    this.banner,
    this.category,
    this.bestDeals,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}

@JsonSerializable()
class Store {
  @JsonKey(name: "store_id")
  final int? storeId;
  @JsonKey(name: "store_name")
  final String? storeName;
  @JsonKey(name: "store_descreption")
  final String? storeDescreption;
  @JsonKey(name: "store_image")
  final String? storeImage;
  @JsonKey(name: "store_phone")
  final String? storePhone;
  @JsonKey(name: "store_discount_title")
  final String? storeDiscountTitle;

  Store ({
    this.storeId,
    this.storeName,
    this.storeDescreption,
    this.storeImage,
    this.storePhone,
    this.storeDiscountTitle,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return _$StoreFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StoreToJson(this);
  }
}

@JsonSerializable()
class Discount {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "discounts")
  final List<Discounts>? discounts;

  Discount ({
    this.status,
    this.discounts,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return _$DiscountFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DiscountToJson(this);
  }
}

@JsonSerializable()
class Discounts {
  @JsonKey(name: "id_discount")
  final int? idDiscount;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "subtitle")
  final String? subtitle;
  @JsonKey(name: "image_url")
  final String? imageUrl;
  @JsonKey(name: "image_icon")
  final String? imageIcon;
  @JsonKey(name: "discount_percentage")
  final int? discountPercentage;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "expiry_datetime")
  final String? expiryDatetime;

  Discounts ({
    this.idDiscount,
    this.title,
    this.subtitle,
    this.imageUrl,
    this.discountPercentage,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imageIcon,
    this.expiryDatetime,
  });

  factory Discounts.fromJson(Map<String, dynamic> json) {
    return _$DiscountsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DiscountsToJson(this);
  }
}

@JsonSerializable()
class Banner {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "banners")
  final List<Banners>? banners;

  Banner ({
    this.status,
    this.banners,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return _$BannerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BannerToJson(this);
  }
}

@JsonSerializable()
class Banners {
  @JsonKey(name: "banners_id")
  final int? bannersId;
  @JsonKey(name: "banners_url_image")
  final String? bannersUrlImage;
  @JsonKey(name: "banners_title")
  final String? bannersTitle;
  @JsonKey(name: "banners_description")
  final String? bannersDescription;
  @JsonKey(name: "banners_productId")
  final int? bannersProductId;
  @JsonKey(name: "banners_status")
  final int? bannersStatus;
  @JsonKey(name: "banners_created_at")
  final String? bannersCreatedAt;

  Banners ({
    this.bannersId,
    this.bannersUrlImage,
    this.bannersTitle,
    this.bannersDescription,
    this.bannersProductId,
    this.bannersStatus,
    this.bannersCreatedAt,
  });

  factory Banners.fromJson(Map<String, dynamic> json) {
    return _$BannersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BannersToJson(this);
  }
}

@JsonSerializable()
class Category {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "categories")
  final List<Categories>? categories;

  Category ({
    this.status,
    this.categories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryToJson(this);
  }
}

@JsonSerializable()
class Categories {
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

  Categories ({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
    this.categoryStatus,
    this.categoryCreatAt,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return _$CategoriesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesToJson(this);
  }
}

@JsonSerializable()
class BestDeals {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "productsBestDeals")
  final List<ProductsBestDeals>? productsBestDeals;

  BestDeals ({
    this.status,
    this.productsBestDeals,
  });

  factory BestDeals.fromJson(Map<String, dynamic> json) {
    return _$BestDealsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BestDealsToJson(this);
  }
}

@JsonSerializable()
class ProductsBestDeals {
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

  ProductsBestDeals ({
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

  factory ProductsBestDeals.fromJson(Map<String, dynamic> json) {
    return _$ProductsBestDealsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsBestDealsToJson(this);
  }
  ProductsRelations toProductsRelations() => ProductsRelations(
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
      categoryCreatAt: categoryCreatAt);
}


