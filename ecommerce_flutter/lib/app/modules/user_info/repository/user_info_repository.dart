import '../../../core/models/user.dart';
import '../api/user_info_api.dart';

class UserInfoRepository {
  final UserInfoApi _api;

  UserInfoRepository(this._api);

  Future<User> updateUserInfo({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    return _api.updateUserInfo(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );
  }

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return _api.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
