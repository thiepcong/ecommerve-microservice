import 'package:ecommerce_flutter/app/network/exceptions/bad_request_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/user.dart';
import '../repository/user_info_repository.dart';
import 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(this._repo) : super(const UserInfoState());

  final UserInfoRepository _repo;

  void init() async {
    emit(state.copyWith(message: null, isLoading: true));
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getInt("userId");
    final lastName = pre.getString("lastName");
    final firstName = pre.getString("firstName");
    final email = pre.getString("email");
    final phoneNumber = pre.getString("phoneNumber");
    if (userId == null ||
        lastName == null ||
        firstName == null ||
        email == null ||
        phoneNumber == null) return;
    final user = User(
      id: userId,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );
    emit(state.copyWith(user: user, isLoading: false));
  }

  void changeInfo(String firstName, String lastName, String phoneNumber) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.updateUserInfo(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );
      final pre = await SharedPreferences.getInstance();
      await pre.setString("lastName", res.lastName);
      await pre.setString("firstName", res.firstName);
      await pre.setString("phoneNumber", res.phoneNumber);
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
}
