import '../../../core/base/base_remote_source.dart';
import '../../../core/models/user.dart';
import '../../../core/values/api_url_constant.dart';

class LoginApi extends BaseRemoteSource {
  Future<User> login({
    required String usename,
    required String password,
  }) async {
    final request = dioClient.post(ApiUrlConstants.login, data: {
      "username": usename,
      "password": password,
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => User.fromJson(value.data["user"]));
    } catch (e) {
      rethrow;
    }
  }

  Future<User> register({
    required String name,
    required String usename,
    required String password,
  }) async {
    final request = dioClient.post(ApiUrlConstants.register, data: {
      "username": usename,
      "password": password,
      "name": name,
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => User.fromJson(value.data["user"]));
    } catch (e) {
      rethrow;
    }
  }
}
