import '../../../core/base/base_remote_source.dart';
import '../../../core/models/user.dart';
import '../../../core/values/api_url_constant.dart';

class LoginApi extends BaseRemoteSource {
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final request = dioClient.post(ApiUrlConstants.login, data: {
      "email": email,
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
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    final request = dioClient.post(ApiUrlConstants.register, data: {
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
      "email": email,
      "password": password,
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => User.fromJson(value.data["user"]));
    } catch (e) {
      rethrow;
    }
  }
}
