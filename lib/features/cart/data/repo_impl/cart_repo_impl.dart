




import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/cart/data/data_sources/cart_data_sources_repo.dart';
import 'package:manarat_amjad/features/cart/data/models/request/add_address.dart';
import 'package:manarat_amjad/features/cart/data/models/request/add_to_cart_request.dart';
import 'package:manarat_amjad/features/cart/data/models/request/delete_item_cart_request.dart';
import 'package:manarat_amjad/features/cart/data/models/request/update_cart_item.dart';
import 'package:manarat_amjad/features/cart/domain/entities/cart_entities.dart';
import 'package:manarat_amjad/features/cart/domain/repo/cart_repo.dart';
import 'package:injectable/injectable.dart';



@Injectable(as: CartRepo)
class CartRepoImpl extends CartRepo {
  final CartDataSourcesRepo cartDataSourcesRepo;

  CartRepoImpl(this.cartDataSourcesRepo);


  @override
  Future<Result<CartEntity?>> getCart() {
    return cartDataSourcesRepo.getCart();
  }

  @override
  Future<Result<AddToCartEntity?>> addCart(AddToCartRequest addToCartRequest) {
    return cartDataSourcesRepo.addCart(addToCartRequest);
  }

  @override
  Future<Result<UpdateCartItemEntity?>> updateCart(UpdateCartItemRequest updateCartItemRequest) {
  return cartDataSourcesRepo.updateCart(updateCartItemRequest);
  }

  @override
  Future<Result<DelItemCartEntity?>> deleteCart(DeleteItemCartRequest deleteItemCartRequest) {
return cartDataSourcesRepo.deleteCart(deleteItemCartRequest);
  }



  // @override
  // Future<Result<AddAddressUserEntity?>> addAddressesUser(AddAddressRequest addAddressRequest) {
  //   return cartDataSourcesRepo.addAddressesUser(addAddressRequest);
  // }





}