import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/cart/data/models/request/add_address.dart';
import 'package:manarat_amjad/features/cart/data/models/request/add_to_cart_request.dart';
import 'package:manarat_amjad/features/cart/data/models/request/delete_item_cart_request.dart';
import 'package:manarat_amjad/features/cart/data/models/request/update_cart_item.dart';
import 'package:manarat_amjad/features/cart/domain/entities/cart_entities.dart';

abstract class CartRepo {
  Future<Result<CartEntity?>> getCart();

  Future<Result<AddToCartEntity?>> addCart(AddToCartRequest addToCartRequest);

  Future<Result<UpdateCartItemEntity?>> updateCart(
    UpdateCartItemRequest updateCartItemRequest,
  );

  Future<Result<DelItemCartEntity?>> deleteCart(DeleteItemCartRequest deleteItemCartRequest);



  // Future<Result<AddAddressUserEntity?>> addAddressesUser(AddAddressRequest addAddressRequest);
}
