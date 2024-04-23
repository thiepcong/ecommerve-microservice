import '../../network/dio_provider.dart';

final baseUrl = DioProvider.baseUrl;

class ApiUrlConstants {
  static String register = '$baseUrl:4000/api/ecomSys/user/register/';

  static String login = '$baseUrl:4000/api/ecomSys/user/login/';

  static String search(String key) =>
      '$baseUrl:4003/api/ecomSys/search?key=$key';
}
