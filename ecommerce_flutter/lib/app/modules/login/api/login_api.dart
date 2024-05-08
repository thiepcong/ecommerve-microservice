import 'dart:math';

import 'package:intl/intl.dart';

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
          .then((value) => User.fromJson(value.data));
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
    required String address,
    required DateTime dob,
    required int position,
  }) async {
    final request = dioClient.post(ApiUrlConstants.register, data: {
      "id": Random().nextInt(100000).toString(),
      "fname": firstName,
      "lname": lastName,
      "mobile": phoneNumber,
      "email": email,
      "password": password,
      "address": address,
      "dob": DateFormat('yyyy-MM-dd').format(dob),
      "position": position,
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => User.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }
}
