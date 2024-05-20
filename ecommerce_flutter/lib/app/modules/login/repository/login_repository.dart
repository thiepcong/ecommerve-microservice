import '../../../core/models/user.dart';
import '../api/login_api.dart';

class LoginRepository {
  final LoginApi _api;
  LoginRepository(this._api);

  Future<User> login({required String email, required String password}) {
    return _api.login(email: email, password: password);
  }

  Future<User> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required String province,
    required String district,
    required String ward,
    required String street,
    required DateTime dob,
    required int position,
  }) async {
    return _api.register(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      password: password,
      province: province,
      district: district,
      ward: ward,
      street: street,
      dob: dob,
      position: position,
    );
  }
}
