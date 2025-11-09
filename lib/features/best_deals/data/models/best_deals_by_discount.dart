import 'package:fada_alhalij_web/features/best_deals/domain/entities/best_deals_by_categories_entity.dart';

import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
class BestDealsByDiscountDto {
  BestDealsByDiscountDto({this.status, this.bestDeals});

  BestDealsByDiscountDto.fromJson(dynamic json) {
    status = json['status'];
    if (json['bestDeals'] != null) {
      bestDeals = [];
      json['bestDeals'].forEach((v) {
        bestDeals?.add(BestDeals.fromJson(v));
      });
    }
  }

  String? status;
  List<BestDeals>? bestDeals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (bestDeals != null) {
      map['bestDeals'] = bestDeals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  BestDealsByDiscountEntity toBestDealsByDiscountEntity() =>
      BestDealsByDiscountEntity(status: status, bestDeals: bestDeals);
}

class BestDeals {
  BestDeals({
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

  BestDeals.fromJson(dynamic json) {
    idProduct = json['id_product'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    description = json['description'];
    imageCover = json['image_cover'];
    productPriceAfterDiscount = json['product_price_after_discount'];
    category = json['category'];
    descount = json['descount'];
    status = json['status'];
    dateDescount = json['date_descount'];
    createdAt = json['createdAt'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    categoryStatus = json['category_status'];
    categoryCreatAt = json['category_creatAt'];
  }

  int? idProduct;
  String? productName;
  num? productPrice;
  String? description;
  String? imageCover;
  num? productPriceAfterDiscount;
  int? category;
  int? descount;
  int? status;
  String? dateDescount;
  String? createdAt;
  int? categoryId;
  String? categoryName;
  String? categoryImage;
  int? categoryStatus;
  String? categoryCreatAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_product'] = idProduct;
    map['product_name'] = productName;
    map['product_price'] = productPrice;
    map['description'] = description;
    map['image_cover'] = imageCover;
    map['product_price_after_discount'] = productPriceAfterDiscount;
    map['category'] = category;
    map['descount'] = descount;
    map['status'] = status;
    map['date_descount'] = dateDescount;
    map['createdAt'] = createdAt;
    map['category_id'] = categoryId;
    map['category_name'] = categoryName;
    map['category_image'] = categoryImage;
    map['category_status'] = categoryStatus;
    map['category_creatAt'] = categoryCreatAt;
    return map;
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
