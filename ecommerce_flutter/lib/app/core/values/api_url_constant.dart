import '../../network/dio_provider.dart';

final baseUrl = DioProvider.baseUrl;

class ApiUrlConstants {
  static String register = '$baseUrl:4000/api/ecomSys/user/register/';

  static String login = '$baseUrl:4000/api/ecomSys/user/login/';

  static String updateUserInfo = '$baseUrl:4000/api/ecomSys/user/update/';

  static String changePassword = '$baseUrl:4000/api/ecomSys/user/change/';

  static String search(String key) =>
      '$baseUrl:4003/api/ecomSys/search?key=$key';

  static String getAllCartItem = '$baseUrl:4004/api/ecomSys/cart/show/';

  static String addToCart = '$baseUrl:4004/api/ecomSys/cart/add/';

  static String deleteCartItem(String productId) =>
      '$baseUrl:4004/api/ecomSys/cart/delete/$productId/';
}
