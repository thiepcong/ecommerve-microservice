import 'package:ecommerce_flutter/app/network/exceptions/bad_request_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/user.dart';
import '../repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repo) : super(const HomeState());

  final HomeRepository _repo;

  void init() async {
    emit(state.copyWith(message: null, isLoading: true));
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getString("userId");
    final lastName = pre.getString("lastName");
    final firstName = pre.getString("firstName");
    final email = pre.getString("email");
    final mobile = pre.getString("mobile");
    if (userId == null ||
        lastName == null ||
        firstName == null ||
        email == null ||
        mobile == null) return;
    final user = User(
      id: userId,
      email: email,
      firstName: firstName,
      lastName: lastName,
      mobile: mobile,
      address: '',
      dob: DateTime.now(),
      password: '',
      position: -1,
    );
    emit(state.copyWith(user: user, isLoading: false));
  }

  void search(String key) async {
    try {
      emit(state.copyWith(message: null, isLoading: true));
      final res = await _repo.search(key: key);
      emit(state.copyWith(products: res, isLoading: false));
    } catch (e) {
      if (e is BadRequestException) {
        emit(state.copyWith(message: "Đã có lỗi xảy ra!", isLoading: false));
        return;
      }
      rethrow;
    }
  }

  void setFilter(String filter) {
    emit(state.copyWith(filter: filter));
  }
}
