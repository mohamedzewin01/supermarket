import 'package:manarat_amjad/features/categories/domain/entities/categories_zone_entity.dart';

class CategoriesZoneResponse {
  String? status;
  List<Categories>? categories;

  CategoriesZoneResponse({this.status, this.categories});

  CategoriesZoneResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CategoriesZoneEntity toCategoriesZoneEntity() =>
      CategoriesZoneEntity(categories: categories);
}

class Categories {
  int? categoryId;
  String? categoryName;
  String? categoryImage;
  int? categoryStatus;
  String? categoryCreatAt;

  Categories({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
    this.categoryStatus,
    this.categoryCreatAt,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    categoryStatus = json['category_status'];
    categoryCreatAt = json['category_creatAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    data['category_status'] = this.categoryStatus;
    data['category_creatAt'] = this.categoryCreatAt;
    return data;
  }
}
