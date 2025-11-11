import 'package:manarat_amjad/core/api/api_extentions.dart';
import 'package:manarat_amjad/core/api/api_manager/api_manager.dart';
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/best_deals/domain/entities/best_deals_by_categories_entity.dart';

import 'package:injectable/injectable.dart';

@injectable
class BestDealsDataSources {
  ApiService apiService;

  BestDealsDataSources(this.apiService);

  Future<Result<BestDealsByCategoriesEntity?>> getBestDealsByCategories() {
    return executeApi(() async {
      var response = await apiService.getBestDealsByCategories();
      return response?.toBestDealsByCategoriesEntity();
    });
  }
  Future<Result<BestDealsByDiscountEntity?>> getBestDealsByDiscount(int? discount) {
    return executeApi(() async {
      var response = await apiService.fetchBestDealsByDiscount(discount);
      return response?.toBestDealsByDiscountEntity();
    });
    
  }

  Future<Result<FetchBestDealsEntity?>> getAllBestDeals() {
    return executeApi(() async {
      var response = await apiService.fetchBestDeals();
      return response?.toFetchBestDealsEntity();
    });

  }

}
