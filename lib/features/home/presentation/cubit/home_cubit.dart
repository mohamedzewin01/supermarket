

import 'package:bloc/bloc.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../core/common/api_result.dart';
import '../../domain/entities/home_entities.dart';
import '../../domain/use_cases/home_use_case.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase _homeUseCase;

  HomeCubit(this._homeUseCase) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> getHomeData() async {
    emit(HomeLoading());
    final result = await _homeUseCase.getHomeData();
    switch (result) {
      case Success<HomeEntity?>():
        {
          if (!isClosed) {
            CacheService.setData(
              key: CacheKeys.storeName,
              value: result.data?.data?.store?.storeName ?? '',
            );
            CacheService.setData(
              key: CacheKeys.storeDescription,
              value: result.data?.data?.store?.storeDescreption ?? '',
            );
            CacheService.setData(
              key: CacheKeys.storeUrlImage,
              value: result.data?.data?.store?.storeImage ?? '',
            );
            CacheService.setData(
              key: CacheKeys.storeId,
              value: result.data?.data?.store?.storeId ?? '',
            );
            CacheService.setData(
              key: CacheKeys.storePhone,
              value: result.data?.data?.store?.storePhone ?? '',
            );
            emit(HomeSuccess(result.data));
          }

        }

      case Fail<HomeEntity?>():
        {
          emit(HomeFail(result.exception));
        }
    }
  }
}
