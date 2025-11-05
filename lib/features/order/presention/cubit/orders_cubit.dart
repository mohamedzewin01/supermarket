import 'package:bloc/bloc.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/core/uses_cases/orders/add_order_use_case_repo.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import 'package:fada_alhalij_web/core/utils/firebase_utils.dart';
import 'package:fada_alhalij_web/features/order/data/models/request/add_order_request.dart';
import 'package:fada_alhalij_web/features/order/domain/entities/orders_entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.addOrderUseCaseRepo) : super(OrdersInitial());

  final AddOrderUseCaseRepo addOrderUseCaseRepo ;
  static OrdersCubit get(context) => BlocProvider.of(context);
  Future<void> addOrder({required int idAddress}) async {
    emit(AddOrdersLoading());
    AddOrderRequest addOrderRequest = AddOrderRequest(
      userId: CacheService.getData(key: CacheKeys.userId) ?? 0,
      userAddress: idAddress
    );
   var result = await addOrderUseCaseRepo.addOrder(addOrderRequest);
  switch (result) {
    case Success<AddOrderEntity?>():
      {
        if (!isClosed) {

          emit(AddOrdersSuccess(result.data!));

        }
      }
    case Fail<AddOrderEntity?>():
      {
        emit(AddOrdersFail(result.exception));
      }
  }
  }




}
