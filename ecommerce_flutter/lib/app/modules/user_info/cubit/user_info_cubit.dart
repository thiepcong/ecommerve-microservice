import 'package:ecommerce_flutter/app/network/exceptions/bad_request_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/address.dart';
import '../../../core/models/user.dart';
import '../repository/user_info_repository.dart';
import 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(this._repo) : super(const UserInfoState());

  final UserInfoRepository _repo;

  void init() async {
    emit(state.copyWith(message: null, isLoading: true));
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getString("userId");
    final lastName = pre.getString("lastName");
    final firstName = pre.getString("firstName");
    final email = pre.getString("email");
    final mobile = pre.getString("mobile");
    final dob = pre.getString("dob");
    final province = pre.getString("province");
    final district = pre.getString("district");
    final ward = pre.getString("ward");
    final street = pre.getString("street");
    if (userId == null ||
        lastName == null ||
        firstName == null ||
        email == null ||
        mobile == null ||
        dob == null ||
        province == null ||
        district == null ||
        ward == null ||
        street == null) return;
    final user = User(
        id: userId,
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        province: province,
        district: district,
        street: street,
        ward: ward,
        dob: DateTime.parse(dob),
        password: '',
        position: -1);
    emit(state.copyWith(user: user, isLoading: false));
    getAllAddress();
  }

  void changeInfo(
    String firstName,
    String lastName,
    String mobile,
    String province,
    String district,
    String ward,
    String street,
    DateTime dob,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.updateUserInfo(
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        province: province,
        district: district,
        ward: ward,
        street: street,
        dob: dob,
      );
      final pre = await SharedPreferences.getInstance();
      await pre.setString("lastName", res.lastName);
      await pre.setString("firstName", res.firstName);
      await pre.setString("mobile", res.mobile);
      await pre.setString("dob", res.dob.toString());
      await pre.setString("province", res.province);
      await pre.setString("district", res.district);
      await pre.setString("ward", res.ward);
      await pre.setString("street", res.street);
      emit(state.copyWith(
        user: res,
        isLoading: false,
        message: "Lưu thành công",
      ));
    } catch (e) {
      if (e is BadRequestException) {
        emit(state.copyWith(message: e.message, isLoading: false));
        return;
      }
      rethrow;
    }
  }

  void changePassword(String oldPassword, String newPassword) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      emit(state.copyWith(isLoading: false, message: res));
    } catch (e) {
      if (e is BadRequestException) {
        emit(state.copyWith(message: e.message, isLoading: false));
        return;
      }
      rethrow;
    }
  }

  void setFilter(int filter) {
    emit(state.copyWith(filter: filter));
  }

  void getAllAddress() async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.getAllAddress();
      emit(state.copyWith(addresses: res, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }

  void addAddress(Address address) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.addAddress(address: address);
      List<Address> li = List.from(state.addresses);
      li.add(res);
      emit(state.copyWith(
        addresses: li,
        isLoading: false,
        message: "Thêm địa chỉ thành công",
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }

  void updateAddress(Address address, int index) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.updateAddress(address: address);
      List<Address> li = List.from(state.addresses);
      li[index] = res;
      emit(state.copyWith(
        addresses: li,
        isLoading: false,
        message: "Sửa địa chỉ thành công",
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }

  void deleteAddress(Address address) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.deleteAddress(address: address);
      List<Address> li = List.from(state.addresses);
      li.remove(address);
      emit(state.copyWith(
        addresses: li,
        isLoading: false,
        message: res,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }
}
