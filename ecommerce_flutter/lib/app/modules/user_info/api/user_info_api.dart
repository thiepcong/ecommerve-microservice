import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_remote_source.dart';
import '../../../core/models/user.dart';
import '../../../core/values/api_url_constant.dart';

class UserInfoApi extends BaseRemoteSource {
  Future<User> updateUserInfo({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    final request = dioClient.put(ApiUrlConstants.updateUserInfo, data: {
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
    });
    try {
      final pre = await SharedPreferences.getInstance();
      final userId = pre.getString("userId");
      final lastName = pre.getString("lastName");
      final firstName = pre.getString("firstName");
      final email = pre.getString("email");
      final phoneNumber = pre.getString("phoneNumber");
      final user = User(
        id: userId ?? '',
        email: email ?? '',
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        mobile: phoneNumber ?? '',
        address: '',
        dob: DateTime.now(),
        password: '',
        position: -1,
      );
      return callApiWithErrorParser(request).then((value) => user);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final request = dioClient.patch(ApiUrlConstants.changePassword, data: {
      "old_password": oldPassword,
      "new_password": newPassword,
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => value.data['message']);
    } catch (e) {
      rethrow;
    }
  }
}
