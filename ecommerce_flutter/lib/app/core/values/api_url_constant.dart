import '../../network/dio_provider.dart';

final baseUrl = DioProvider.baseUrl;

class ApiUrlConstants {
  static String register = '$baseUrl:4001/api/ecomSys/user/register/';

  static String login = '$baseUrl:4001/api/ecomSys/user/login/';

  static String updateUserInfo(String userId) =>
      '$baseUrl:4001/api/ecomSys/user/update/$userId';

  static String changePassword(String userId) =>
      '$baseUrl:4001/api/ecomSys/user/change/$userId';

  static String search(String key, String userId) =>
      '$baseUrl:4003/api/ecomSys/search?key=$key&user_id=$userId';

  static String getAllCartItem = '$baseUrl:4004/api/ecomSys/cart/show/';

  static String addToCart = '$baseUrl:4004/api/ecomSys/cart/add/';

  static String deleteCartItem(String userId, String productId) =>
      '$baseUrl:4004/api/ecomSys/cart/delete/$userId/$productId/';

  static String address = '$baseUrl:4006/api/ecomSys/shipment/shipment-info';

  static String addressDetail(int id) =>
      '$baseUrl:4006/api/ecomSys/shipment/shipment-info/$id';

  static String carrier = '$baseUrl:4006/api/ecomSys/shipment/carrier';
}
