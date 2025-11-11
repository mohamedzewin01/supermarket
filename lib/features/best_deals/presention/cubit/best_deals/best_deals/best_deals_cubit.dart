import 'package:bloc/bloc.dart';
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/best_deals/domain/entities/best_deals_by_categories_entity.dart';
import 'package:manarat_amjad/features/best_deals/domain/use_cases/best_deals_use_cases.dart';
import 'package:meta/meta.dart';

part 'best_deals_state.dart';

class BestDealsCubit extends Cubit<BestDealsState> {
  BestDealsCubit(this._bestDealsUseCases) : super(BestDealsInitial());

  final BestDealsUseCases _bestDealsUseCases ;

  Future<void> getBestDeals() async {
    emit(BestDealsLoading());
    final result = await _bestDealsUseCases.getAllBestDeals();
    switch (result) {
      case Success<FetchBestDealsEntity?>():
        {
          if (!isClosed) {
            emit(BestDealsSuccess(result.data!));
          }
        }
      case Fail<FetchBestDealsEntity?>():
        {
          emit(BestDealsFail(result.exception));
        }
    }

  }
}
