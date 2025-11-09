import 'package:bloc/bloc.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/features/products/domain/entities/products_entities.dart';
import 'package:fada_alhalij_web/features/products/domain/use_cases/products_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsUseCase) : super(ProductsInitial());
  final ProductsUseCase _productsUseCase;

  Future<void> getProductsData({required String idCategory}) async {
    emit(ProductsLoading());

    final result = await _productsUseCase.getHomeData(idCategory,1,3);
    switch (result) {
      case Success<GetProductsByCategoryEntity?>():
        {
          if (!isClosed) {
            emit(ProductsSuccess(result.data));
          }
        }

      case Fail<GetProductsByCategoryEntity?>():
        {
          emit(ProductsFail(result.exception));
        }
    }
  }
}
