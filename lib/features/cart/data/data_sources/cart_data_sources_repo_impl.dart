import 'package:fada_alhalij_web/core/api/api_extentions.dart';
import 'package:fada_alhalij_web/core/api/api_manager/api_manager.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/add_address.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/add_to_cart_request.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/delete_item_cart_request.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/get_cart_request.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/update_cart_item.dart';
import 'package:fada_alhalij_web/features/cart/domain/entities/cart_entities.dart';
import 'package:injectable/injectable.dart';
import 'cart_data_sources_repo.dart';

@Injectable(as: CartDataSourcesRepo)
class CartDataSourcesRepoImpl implements CartDataSourcesRepo {
  final ApiService _apiService;

  CartDataSourcesRepoImpl(this._apiService);

  @override
  Future<Result<AddToCartEntity?>> addCart(AddToCartRequest addToCartRequest) {
    return executeApi(() async {
      var response = await _apiService.addToCart(addToCartRequest);
      return response?.toAddToCartEntity();
    });
  }

  @override
  Future<Result<CartEntity?>> getCart() {
    return executeApi(() async {
      int? userId = await CacheService.getData(key: CacheKeys.userId)??0;
      var response = await _apiService.getCart(
        GetCartRequest(userId: userId),
      );
      return response?.toCartEntities();
    });
  }

  @override
  Future<Result<UpdateCartItemEntity?>> updateCart(
    UpdateCartItemRequest updateCartItemRequest,
  ) {
    return executeApi(() async {
      var response = await _apiService.updateCartItem(updateCartItemRequest);
      return response?.toUpdateCartItemEntity();
    });
  }

  @override
  Future<Result<DelItemCartEntity?>> deleteCart(DeleteItemCartRequest deleteItemCartRequest) {
    return executeApi(() async {
      var response = await _apiService.deleteCartItem(deleteItemCartRequest);
      return response?.toDelItemCartEntity();
    });
  }



  // @override
  // Future<Result<AddAddressUserEntity?>> addAddressesUser(AddAddressRequest addAddressRequest) {
  //   return executeApi(() async {
  //     var response = await _apiService.addAddressesUser(addAddressRequest);
  //     return response?.toAddAddressUserEntity();
  //   });
  // }
}
