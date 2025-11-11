

import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/categories/domain/entities/categories_zone_entity.dart';

abstract class CategoriesZoneRepo {
  Future<Result<CategoriesZoneEntity?>> getCategories();
}
