class ApiConstants {
  static const String baseUrl = "https://artawiya.com/manartamjaadDB/api/v2/";
  static const String baseUrlImage =
      "https://artawiya.com/manartamjaadDB/api/v2/upload/";

  /// TODO: change v1 to v2  and change location image to upload in v2

  // static const String home = "home/home_view_v2";

  static const String home = "home/home_view_3";
  static const String signUp = "auth/signup";
  static const String signIn = "auth/signin";
  static const String categories = "categories/fetchCategories.php";
  static const String fetchBestDeals = "bestDeals/fetchBestDeals";
  static const String fetchBanners = "banners/fetchBanners.php";
  static const String fetchProductsByCategories = "products/new_fetch_products.php";
  static const String fetchBestDealsByCate = "bestDeals/fetchBestDealsByCate.php";
  static const String addDevice = "analytics/device/add_device";
  static const String productVisit = "analytics/product_visits/add_product_visit";
  static const String fetchBestDealsByDiscount = "bestDeals/fetchBestDealsByDiscount";
  static const String addToCart = "cart/addtoCart";
  static const String getCart = "cart/cart";
  static const String updateCartItem = "cart/updateCartItem";
  static const String cartDeleteItem = "cart/deleteItem";
  static const String getUserAddresses = "address/get_user_addresses";
  static const String addAddress = "address/add_address";
  static const String editAddress = "address/edit_address";
  static const String addOrders = "orders/orders.php";
  static const String getActiveOrders = "orders/getActiveOrders";
  static const String getCompletedOrder = "orders/getCompletedOrder";
  static const String getDeliveryAreas = "areas/get_delivery_areas";
  static const String search = "search/search_paginationV2";
  static const String editProfile = "profile/editProfile";
  static const String getUserInfo = "profile/getUserInfo";
}
