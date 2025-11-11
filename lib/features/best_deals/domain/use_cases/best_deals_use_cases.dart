import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/best_deals/domain/entities/best_deals_by_categories_entity.dart';
import 'package:manarat_amjad/features/best_deals/domain/repo/best_deals_repo.dart';

import 'package:injectable/injectable.dart';

@injectable
class BestDealsUseCases {
  final BestDealsRepo bestDealsRepo;

  BestDealsUseCases(this.bestDealsRepo);

  Future<Result<BestDealsByCategoriesEntity?>> getBestDealsByCategories() =>
      bestDealsRepo.getBestDealsByCategories();
  Future<Result<BestDealsByDiscountEntity?>> getBestDealsByDiscount(int? discount) =>
      bestDealsRepo.getBestDealsByDiscount(discount);
  Future<Result<FetchBestDealsEntity?>> getAllBestDeals(){
    return bestDealsRepo.getAllBestDeals();
  }
}
