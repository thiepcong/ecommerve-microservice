import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/user.dart';
import '../repository/purchase_repository.dart';
import 'purchase_state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  PurchaseCubit(this._repo) : super(const PurchaseState());

  final PurchaseRepository _repo;

  void getOrderByUser() async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
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
        district: '',
        province: '',
        street: '',
        ward: '',
        dob: DateTime.now(),
        password: '',
        position: -1,
      );
      emit(state.copyWith(user: user));
      final res = await _repo.getOrderByUser();
      emit(state.copyWith(orders: res, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra!"));
      rethrow;
    }
  }

  void cancelOrder(int orderId) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.cancelOrder(orderId);
      emit(state.copyWith(message: res, isLoading: false));
      getOrderByUser();
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra!"));
      rethrow;
    }
  }
}
