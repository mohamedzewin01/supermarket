import 'package:bloc/bloc.dart';
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/best_deals/domain/entities/best_deals_by_categories_entity.dart';
import 'package:manarat_amjad/features/best_deals/domain/use_cases/best_deals_use_cases.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'best_discount_by_discount_state.dart';

@injectable
class BestDiscountByDiscountCubit extends Cubit<BestDiscountByDiscountState> {
  BestDiscountByDiscountCubit(this._bestDealsUseCases)
    : super(BestDiscountByDiscountInitial());

  final BestDealsUseCases _bestDealsUseCases;

  Future<void> getBestDealsByCategories(int? discount) async {
    emit(BestDiscountByDiscountLoading());
    final result = await _bestDealsUseCases.getBestDealsByDiscount(discount);
    switch (result) {
      case Success<BestDealsByDiscountEntity?>():
        {
          if (!isClosed) {
            emit(BestDiscountByDiscountSuccess(result.data!));
          }
        }
      case Fail<BestDealsByDiscountEntity?>():
        {
          emit(BestDiscountByDiscountFail(result.exception));
        }
    }
  }
}
