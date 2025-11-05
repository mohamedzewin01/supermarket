// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_manager.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://artawiya.com/manartamjaadDB/api/v2/';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<HomeModelResponseDto?> getHomeData() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HomeModelResponseDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'home/home_view_3',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late HomeModelResponseDto? _value;
    try {
      _value =
          _result.data == null
              ? null
              : HomeModelResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AuthSignupResponseDto?> signUp(
    AuthSignupRequest authSignupRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(authSignupRequest.toJson());
    final _options = _setStreamType<AuthSignupResponseDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'auth/signup',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late AuthSignupResponseDto? _value;
    try {
      _value =
          _result.data == null
              ? null
              : AuthSignupResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AuthSingInResponseDto?> signIn(
    AuthSignInRequest authSignInRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(authSignInRequest.toJson());
    final _options = _setStreamType<AuthSingInResponseDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'auth/signin',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late AuthSingInResponseDto? _value;
    try {
      _value =
          _result.data == null
              ? null
              : AuthSingInResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<CategoriesZoneResponse> getCategories() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<CategoriesZoneResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'categories/fetchCategories.php',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late CategoriesZoneResponse _value;
    try {
      _value = CategoriesZoneResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BestDealsByCategoriesModel?> getBestDealsByCategories() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BestDealsByCategoriesModel>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'bestDeals/fetchBestDealsByCate.php',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late BestDealsByCategoriesModel? _value;
    try {
      _value =
          _result.data == null
              ? null
              : BestDealsByCategoriesModel.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ProductsModelResponse> getProductsByCategory(String idCategory) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('idCategory', idCategory));
    final _options = _setStreamType<ProductsModelResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'products/fetchProductsByCategories.php',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ProductsModelResponse _value;
    try {
      _value = ProductsModelResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<DeviceResponse> addDevice(String? deviceId, String? deviceName) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (deviceId != null) {
      _data.fields.add(MapEntry('deviceId', deviceId));
    }
    if (deviceName != null) {
      _data.fields.add(MapEntry('deviceName', deviceName));
    }
    final _options = _setStreamType<DeviceResponse>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data',
          )
          .compose(
            _dio.options,
            'analytics/device/add_device',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late DeviceResponse _value;
    try {
      _value = DeviceResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<dynamic> addProductVisit(int? deviceId, int? productId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (deviceId != null) {
      _data.fields.add(MapEntry('deviceId', deviceId.toString()));
    }
    if (productId != null) {
      _data.fields.add(MapEntry('productId', productId.toString()));
    }
    final _options = _setStreamType<dynamic>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data',
          )
          .compose(
            _dio.options,
            'analytics/product_visits/add_product_visit',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch(_options);
    final _value = _result.data;
    return _value;
  }

  @override
  Future<BestDealsByDiscountDto?> fetchBestDealsByDiscount(
    int? numDiscount,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (numDiscount != null) {
      _data.fields.add(MapEntry('discount', numDiscount.toString()));
    }
    final _options = _setStreamType<BestDealsByDiscountDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'bestDeals/fetchBestDealsByDiscount',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late BestDealsByDiscountDto? _value;
    try {
      _value =
          _result.data == null
              ? null
              : BestDealsByDiscountDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AddToCartResponseDto?> addToCart(
    AddToCartRequest addToCartRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(addToCartRequest.toJson());
    final _options = _setStreamType<AddToCartResponseDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'cart/addtoCart',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late AddToCartResponseDto? _value;
    try {
      _value =
          _result.data == null
              ? null
              : AddToCartResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<CartDto?> getCart(GetCartRequest getCartResponse) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(getCartResponse.toJson());
    final _options = _setStreamType<CartDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'cart/cart',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late CartDto? _value;
    try {
      _value = _result.data == null ? null : CartDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<UpdateCartItemResponseDto?> updateCartItem(
    UpdateCartItemRequest updateCartItemRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(updateCartItemRequest.toJson());
    final _options = _setStreamType<UpdateCartItemResponseDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'cart/updateCartItem',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late UpdateCartItemResponseDto? _value;
    try {
      _value =
          _result.data == null
              ? null
              : UpdateCartItemResponseDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<DelItemCartDto?> deleteCartItem(
    DeleteItemCartRequest deleteItemCartRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(deleteItemCartRequest.toJson());
    final _options = _setStreamType<DelItemCartDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'cart/deleteItem',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late DelItemCartDto? _value;
    try {
      _value =
          _result.data == null ? null : DelItemCartDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<FetchBestDeals?> fetchBestDeals() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<FetchBestDeals>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'bestDeals/fetchBestDeals',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late FetchBestDeals? _value;
    try {
      _value =
          _result.data == null ? null : FetchBestDeals.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetUserAddressesDto?> fetchAddressesUser(
    GetUserAddressesRequest getUserAddressRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(getUserAddressRequest.toJson());
    final _options = _setStreamType<GetUserAddressesDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'address/get_user_addresses',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late GetUserAddressesDto? _value;
    try {
      _value =
          _result.data == null
              ? null
              : GetUserAddressesDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AddAddressDto?> addAddressesUser(
    AddAddressRequest addAddressRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(addAddressRequest.toJson());
    final _options = _setStreamType<AddAddressDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'address/add_address',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late AddAddressDto? _value;
    try {
      _value =
          _result.data == null ? null : AddAddressDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<AddOrderDto?> addOrder(AddOrderRequest addOrderRequest) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(addOrderRequest.toJson());
    final _options = _setStreamType<AddOrderDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'orders/orders.php',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late AddOrderDto? _value;
    try {
      _value =
          _result.data == null ? null : AddOrderDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetActiveOrdersDto?> getActiveOrders(
    GetActiveOrdersRequest getActiveOrdersRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(getActiveOrdersRequest.toJson());
    final _options = _setStreamType<GetActiveOrdersDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'orders/getActiveOrders',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late GetActiveOrdersDto? _value;
    try {
      _value =
          _result.data == null
              ? null
              : GetActiveOrdersDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetActiveOrdersDto?> getCompletedOrder(
    GetActiveOrdersRequest getActiveOrdersRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(getActiveOrdersRequest.toJson());
    final _options = _setStreamType<GetActiveOrdersDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'orders/getCompletedOrder',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late GetActiveOrdersDto? _value;
    try {
      _value =
          _result.data == null
              ? null
              : GetActiveOrdersDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetDeliveryAreasDto?> getDeliveryAreas() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetDeliveryAreasDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'areas/get_delivery_areas',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late GetDeliveryAreasDto? _value;
    try {
      _value =
          _result.data == null
              ? null
              : GetDeliveryAreasDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<SearchDto?> search(SearchRequest searchRequest) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(searchRequest.toJson());
    final _options = _setStreamType<SearchDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'search/search_paginationV2',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late SearchDto? _value;
    try {
      _value = _result.data == null ? null : SearchDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<EditAddressDto?> editAddress(
    EditAddressRequest editAddressRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(editAddressRequest.toJson());
    final _options = _setStreamType<EditAddressDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'address/edit_address',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late EditAddressDto? _value;
    try {
      _value =
          _result.data == null ? null : EditAddressDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<EditProfileDto?> editProfile(
    EditProfileRequest editProfileRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(editProfileRequest.toJson());
    final _options = _setStreamType<EditProfileDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'profile/editProfile',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late EditProfileDto? _value;
    try {
      _value =
          _result.data == null ? null : EditProfileDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GetProfileUserInfoDto?> getUserInfo(
    GetUserInfoRequest getUserInfoRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(getUserInfoRequest.toJson());
    final _options = _setStreamType<GetProfileUserInfoDto>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'profile/getUserInfo',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late GetProfileUserInfoDto? _value;
    try {
      _value =
          _result.data == null
              ? null
              : GetProfileUserInfoDto.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
