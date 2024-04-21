import '../../../core/models/user.dart';
import '../api/login_api.dart';

class LoginRepository {
  final LoginApi _api;
  LoginRepository(this._api);

  Future<User> login({
    required String usename,
    required String password,
  }) {
    return _api.login(usename: usename, password: password);
  }

  Future<User> register({
    required String name,
    required String usename,
    required String password,
  }) async {
    return _api.register(
      name: name,
      usename: usename,
      password: password,
    );
  }
}
