import '../../../core/models/address.dart';
import '../../../core/models/user.dart';
import '../api/user_info_api.dart';

class UserInfoRepository {
  final UserInfoApi _api;

  UserInfoRepository(this._api);

  Future<User> updateUserInfo({
    required String firstName,
    required String lastName,
    required String mobile,
    required String address,
    required DateTime dob,
  }) async {
    return _api.updateUserInfo(
      firstName: firstName,
      lastName: lastName,
      mobile: mobile,
      address: address,
      dob: dob,
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

  Future<List<Address>> getAllAddress() async {
    return _api.getAllAddress();
  }

  Future<Address> addAddress({required Address address}) async {
    return _api.addAddress(address: address);
  }

  Future<Address> updateAddress({required Address address}) async {
    return _api.updateAddress(address: address);
  }

  Future<String> deleteAddress({required Address address}) async {
    return _api.deleteAddress(address: address);
  }
}
