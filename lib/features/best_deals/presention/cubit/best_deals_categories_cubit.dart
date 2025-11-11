import 'package:bloc/bloc.dart';
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/best_deals/domain/entities/best_deals_by_categories_entity.dart';
import 'package:manarat_amjad/features/best_deals/domain/use_cases/best_deals_use_cases.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'best_deals_categories_state.dart';
@injectable
class BestDealsCategoriesCubit extends Cubit<BestDealsCategoriesState> {
  BestDealsCategoriesCubit(this._bestDealsUseCases) : super(BestDealsCategoriesInitial());

  final BestDealsUseCases _bestDealsUseCases ;

  Future<void> getBestDealsByCategories() async {
    emit(BestDealsCategoriesLoading());
    final result = await _bestDealsUseCases.getBestDealsByCategories();
    switch (result) {
      case Success<BestDealsByCategoriesEntity?>():
        {
          if (!isClosed) {
            emit(BestDealsCategoriesSuccess(result.data!));
          }
        }
    }
  }
}
