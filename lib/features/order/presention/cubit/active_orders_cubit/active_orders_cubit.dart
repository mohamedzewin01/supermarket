import 'package:bloc/bloc.dart';
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/core/uses_cases/orders/add_order_use_case_repo.dart';
import 'package:manarat_amjad/features/order/domain/entities/orders_entities.dart';
import 'package:manarat_amjad/features/order/presention/cubit/orders_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'active_orders_state.dart';


@injectable
class ActiveOrdersCubit extends Cubit<ActiveOrdersState> {
  ActiveOrdersCubit(this.addOrderUseCaseRepo) : super(ActiveOrdersInitial());

  final AddOrderUseCaseRepo addOrderUseCaseRepo ;
  static OrdersCubit get(context) => BlocProvider.of(context);

  Future<void> getActiveOrders() async {
    emit(OrdersActiveLoading());
    var result = await addOrderUseCaseRepo.getActiveOrders();
    switch (result) {
      case Success<GetActiveOrdersEntity?>():
        {
          if (!isClosed) {
            emit(OrdersActiveSuccess(result.data!));
          }
        }
      case Fail<GetActiveOrdersEntity?>():
        {
          emit(OrdersActiveFail(result.exception));
        }
    }
  }


  Future<void> getCompletedOrder() async {
    emit(OrdersCompletedLoading());
    var result = await addOrderUseCaseRepo.getCompletedOrder();
    switch (result) {
      case Success<GetActiveOrdersEntity?>():
        {
          if (!isClosed) {
            emit(OrdersCompletedSuccess(result.data!));
          }
        }
      case Fail<GetActiveOrdersEntity?>():
        {
          emit(OrdersCompletedFail(result.exception));
        }
    }
  }
}
