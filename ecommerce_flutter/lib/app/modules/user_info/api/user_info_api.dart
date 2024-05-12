import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_remote_source.dart';
import '../../../core/models/address.dart';
import '../../../core/models/user.dart';
import '../../../core/values/api_url_constant.dart';

class UserInfoApi extends BaseRemoteSource {
  Future<User> updateUserInfo({
    required String firstName,
    required String lastName,
    required String mobile,
    required String address,
    required DateTime dob,
  }) async {
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getString("userId");
    final request = dioClient.put(
      ApiUrlConstants.updateUserInfo(userId ?? ''),
      data: {
        "fname": firstName,
        "lname": lastName,
        "mobile": mobile,
        'address': address,
        "dob": DateFormat('yyyy-MM-dd').format(dob),
      },
    );
    try {
      final pre = await SharedPreferences.getInstance();
      final userId = pre.getString("userId");
      final lastName1 = pre.getString("lastName");
      final firstName1 = pre.getString("firstName");
      final email1 = pre.getString("email");
      final mobile1 = pre.getString("mobile");
      final address1 = pre.getString("address");
      final dob1 = pre.getString("dob");
      final user = User(
        id: userId ?? '',
        email: email1 ?? '',
        firstName: firstName1 ?? '',
        lastName: lastName1 ?? '',
        mobile: mobile1 ?? '',
        address: address1 ?? '',
        dob: DateTime.parse(dob1 ?? ''),
        password: '',
        position: -1,
      );
      return callApiWithErrorParser(request).then((value) => user.copyWith(
            firstName: firstName,
            lastName: lastName,
            address: address,
            dob: dob,
          ));
    } catch (e) {
      rethrow;
    }
  }

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getString("userId");
    final request =
        dioClient.post(ApiUrlConstants.changePassword(userId ?? ''), data: {
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

  Future<List<Address>> getAllAddress() async {
    final request = dioClient.get(ApiUrlConstants.address);
    try {
      return callApiWithErrorParser(request).then((value) =>
          (value.data as List).map((e) => Address.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<Address> addAddress({required Address address}) async {
    final request = dioClient.post(
      ApiUrlConstants.address,
      data: address.toJson(),
    );
    try {
      return callApiWithErrorParser(request)
          .then((value) => Address.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }

  Future<Address> updateAddress({required Address address}) async {
    final request = dioClient.put(
      ApiUrlConstants.addressDetail(address.id),
      data: address.toJson(),
    );
    try {
      return callApiWithErrorParser(request)
          .then((value) => Address.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteAddress({required Address address}) async {
    final request = dioClient.delete(ApiUrlConstants.addressDetail(address.id));
    try {
      return callApiWithErrorParser(request)
          .then((value) => "Đã xoá thành công");
    } catch (e) {
      rethrow;
    }
  }
}
