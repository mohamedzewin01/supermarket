import 'package:dio/dio.dart';
import 'package:fada_alhalij_web/core/api/api_constants.dart';
import 'package:fada_alhalij_web/features/address/data/models/request/edit_address_request.dart';
import 'package:fada_alhalij_web/features/address/data/models/request/get_user_addresses.dart';
import 'package:fada_alhalij_web/features/address/data/models/response/edit_address_dto.dart';
import 'package:fada_alhalij_web/features/address/data/models/response/get_delivery_areas_dto.dart';
import 'package:fada_alhalij_web/features/address/data/models/response/get_user_dto.dart';
import 'package:fada_alhalij_web/features/analytics/model/device_response.dart';
import 'package:fada_alhalij_web/features/auth/data/models/request/auth_signin_request.dart';
import 'package:fada_alhalij_web/features/auth/data/models/request/auth_signup_request.dart';
import 'package:fada_alhalij_web/features/auth/data/models/request/edit_profile_request.dart';
import 'package:fada_alhalij_web/features/auth/data/models/responses/auth_signup_response_dto.dart';
import 'package:fada_alhalij_web/features/auth/data/models/responses/auth_singin_response_dto.dart';
import 'package:fada_alhalij_web/features/auth/data/models/responses/edit_profile_dto.dart';
import 'package:fada_alhalij_web/features/best_deals/data/models/best_deals_by_categories_model.dart';
import 'package:fada_alhalij_web/features/best_deals/data/models/best_deals_by_discount.dart';
import 'package:fada_alhalij_web/features/best_deals/data/models/fetch_best_deals.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/add_address.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/add_to_cart_request.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/delete_item_cart_request.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/get_cart_request.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/update_cart_item.dart';
import 'package:fada_alhalij_web/features/cart/data/models/response/add_address_dto.dart';
import 'package:fada_alhalij_web/features/cart/data/models/response/add_to_cart_response.dart';
import 'package:fada_alhalij_web/features/cart/data/models/response/cart_dto.dart';
import 'package:fada_alhalij_web/features/cart/data/models/response/del_item_cart_dto.dart';
import 'package:fada_alhalij_web/features/cart/data/models/response/update_tart_item_response.dart';
import 'package:fada_alhalij_web/features/categories/data/models/categories_zone_response.dart';
import 'package:fada_alhalij_web/features/home/data/models/response/home_model_response_dto.dart';
import 'package:fada_alhalij_web/features/order/data/models/request/add_order_request.dart';
import 'package:fada_alhalij_web/features/order/data/models/request/get_active_orders_request.dart';
import 'package:fada_alhalij_web/features/order/data/models/response/add_order_dto.dart';
import 'package:fada_alhalij_web/features/order/data/models/response/get_active_orders_dto.dart';
import 'package:fada_alhalij_web/features/products/data/models/products_model_response.dart';
import 'package:fada_alhalij_web/features/products/data/models/requests/get_products_by_category_request.dart';
import 'package:fada_alhalij_web/features/profile/data/models/request/get_user_info_request.dart';
import 'package:fada_alhalij_web/features/profile/data/models/response/get_user_info_dto.dart';
import 'package:fada_alhalij_web/features/search/data/models/request/search_request.dart';
import 'package:fada_alhalij_web/features/search/data/models/response/search_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_manager.g.dart';

@injectable
@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  @FactoryMethod()
  factory ApiService(Dio dio) = _ApiService;

  @POST(ApiConstants.home)
  Future<HomeModelResponseDto?> getHomeData();

  @POST(ApiConstants.signUp)
  Future<AuthSignupResponseDto?> signUp(
    @Body() AuthSignupRequest authSignupRequest,
  );

  @POST(ApiConstants.signIn)
  Future<AuthSingInResponseDto?> signIn(
    @Body() AuthSignInRequest authSignInRequest,
  );

  @POST(ApiConstants.categories)
  Future<CategoriesZoneResponse> getCategories();

  @POST(ApiConstants.fetchBestDealsByCate)
  Future<BestDealsByCategoriesModel?> getBestDealsByCategories();

  @POST(ApiConstants.fetchProductsByCategories)
  Future<ProductsModelResponse> getProductsByCategory(
   @Body() GetProductsByCategoryRequest getProductsByCategoryRequest,
  );

  @POST(ApiConstants.addDevice)
  @MultiPart()
  Future<DeviceResponse> addDevice(
    @Part(name: 'deviceId') String? deviceId,
    @Part(name: 'deviceName') String? deviceName,
  );

  @POST(ApiConstants.productVisit)
  @MultiPart()
  Future<dynamic> addProductVisit(
    @Part(name: 'deviceId') int? deviceId,
    @Part(name: 'productId') int? productId,
  );

  @POST(ApiConstants.fetchBestDealsByDiscount)
  Future<BestDealsByDiscountDto?> fetchBestDealsByDiscount(
    @Part(name: 'discount') int? numDiscount,
  );

  @POST(ApiConstants.addToCart)
  Future<AddToCartResponseDto?> addToCart(
    @Body() AddToCartRequest addToCartRequest,
  );

  @POST(ApiConstants.getCart)
  Future<CartDto?> getCart(@Body() GetCartRequest getCartResponse);

  @POST(ApiConstants.updateCartItem)
  Future<UpdateCartItemResponseDto?> updateCartItem(
    @Body() UpdateCartItemRequest updateCartItemRequest,
  );

  @POST(ApiConstants.cartDeleteItem)
  Future<DelItemCartDto?> deleteCartItem(
    @Body() DeleteItemCartRequest deleteItemCartRequest,
  );

  @POST(ApiConstants.fetchBestDeals)
  Future<FetchBestDeals?> fetchBestDeals();

  @POST(ApiConstants.getUserAddresses)
  Future<GetUserAddressesDto?> fetchAddressesUser(
    @Body() GetUserAddressesRequest getUserAddressRequest,
  );

  @POST(ApiConstants.addAddress)
  Future<AddAddressDto?> addAddressesUser(
    @Body() AddAddressRequest addAddressRequest,
  );

  @POST(ApiConstants.addOrders)
  Future<AddOrderDto?> addOrder(@Body() AddOrderRequest addOrderRequest);

  @POST(ApiConstants.getActiveOrders)
  Future<GetActiveOrdersDto?> getActiveOrders(
    @Body() GetActiveOrdersRequest getActiveOrdersRequest,
  );

  @POST(ApiConstants.getCompletedOrder)
  Future<GetActiveOrdersDto?> getCompletedOrder(
    @Body() GetActiveOrdersRequest getActiveOrdersRequest,
  );

  @POST(ApiConstants.getDeliveryAreas)
  Future<GetDeliveryAreasDto?> getDeliveryAreas();

  @POST(ApiConstants.search)
  Future<SearchDto?> search(
    @Body() SearchRequest searchRequest,
  );

  @POST(ApiConstants.editAddress)
  Future<EditAddressDto?> editAddress(
      @Body() EditAddressRequest editAddressRequest,
      );

  @POST(ApiConstants.editProfile)
  Future<EditProfileDto?> editProfile(
      @Body() EditProfileRequest editProfileRequest,
      );

  @POST(ApiConstants.getUserInfo)
  Future<GetProfileUserInfoDto?> getUserInfo(
      @Body() GetUserInfoRequest getUserInfoRequest,
      );

}

//  @MultiPart()
