// import 'package:bloc/bloc.dart';
// import 'package:manarat_amjad/core/common/api_result.dart';
// import 'package:manarat_amjad/core/utils/cashed_data_shared_preferences.dart';
// import 'package:manarat_amjad/features/cart/data/models/request/add_to_cart_request.dart';
// import 'package:manarat_amjad/features/cart/data/models/request/delete_item_cart_request.dart';
// import 'package:manarat_amjad/features/cart/data/models/request/update_cart_item.dart';
// import 'package:manarat_amjad/features/cart/data/models/response/cart_dto.dart';
// import 'package:manarat_amjad/features/cart/domain/entities/cart_entities.dart';
// import 'package:manarat_amjad/features/cart/domain/use_cases/cart_use_case.dart';
// import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:meta/meta.dart';
//
// part 'cart_update_state.dart';
// @injectable
// class CartUpdateCubit extends Cubit<CartUpdateState> {
//   CartUpdateCubit(this._cartUseCase) : super(CartUpdateInitial());
//   final CartUseCase _cartUseCase;
//
//   static CartCubit get(context) => BlocProvider.of(context);
//
//   int? idUser = CacheService.getData(key: CacheConstants.userId) ?? 0;
//
//   // List<CartItems> cartItems = [];
//   // Cart? myCart;
//   // num total = 0;
//
//
//
//
//
//
//
//
//
//
//   Future<void> removeItemFromCart({required int productId,required int index}) async{
//     var result =await _cartUseCase.deleteCart(
//       DeleteItemCartRequest(
//         productId: productId,
//         userId: idUser,
//       ),
//     );
//     switch (result) {
//       case Success<DelItemCartEntity?>():
//         {
//
//       emit(CartRemoveItem());
//
//
//         }
//       case Fail<DelItemCartEntity?>():
//         {
//
//         }
//     }
//
//
//
//
//   }
//
// }
