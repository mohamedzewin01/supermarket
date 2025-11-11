import 'package:manarat_amjad/features/best_deals/data/models/best_deals_by_categories_model.dart';
import 'package:manarat_amjad/features/best_deals/data/models/best_deals_by_discount.dart';
import 'package:manarat_amjad/features/best_deals/data/models/fetch_best_deals.dart';

class BestDealsByCategoriesEntity {
  BestDealsByCategoriesEntity({
    this.categoryList,});


  List<CategoryList>? categoryList;



}

class BestDealsByDiscountEntity {
  BestDealsByDiscountEntity({
    this.status,
    this.bestDeals,});


  String? status;
  List<BestDeals>? bestDeals;



}


class FetchBestDealsEntity {

  final String? status;

  final List<AllBestDeals>? bestDeals;

  FetchBestDealsEntity ({
    this.status,
    this.bestDeals,
  });


}