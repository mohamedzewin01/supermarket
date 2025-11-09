
import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/features/categories/domain/entities/categories_zone_entity.dart';
import 'package:fada_alhalij_web/features/categories/domain/use_cases/categoriesUseCase.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesZoneUseCase _categoriesZoneUseCase;

  CategoriesCubit(this._categoriesZoneUseCase) : super(CategoriesInitial());



  static CategoriesCubit get(context) => BlocProvider.of(context);

  Future<void> getCategories() async {
    emit(CategoriesLoading());

    final result = await _categoriesZoneUseCase.getCategoriesZone();
    switch (result) {
      case Success<CategoriesZoneEntity?>():
        {
          if (!isClosed) {
            emit(CategoriesSuccess(result.data));
          }
        }
      case Fail<CategoriesZoneEntity?>():
        {
          emit(CategoriesFail(result.exception));
        }
    }
  }
  List<ProductsRelations> products = [];


}
