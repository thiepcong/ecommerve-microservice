import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../network/exceptions/bad_request_exception.dart';
import '../../../network/exceptions/network_exception.dart';
import '../repository/login_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginRepository) : super(const LoginState());

  final LoginRepository _loginRepository;

  void login(String email, String password) async {
    try {
      emit(state.copyWith(message: null, isLoading: true));
      final res =
          await _loginRepository.login(email: email, password: password);
      final pre = await SharedPreferences.getInstance();
      await pre.setString("userId", res.id);
      await pre.setString("lastName", res.lastName);
      await pre.setString("firstName", res.firstName);
      await pre.setString("email", res.email);
      await pre.setString("mobile", res.mobile);
      emit(state.copyWith(
        authDone: true,
        isLoading: false,
        user: res,
      ));
    } catch (e) {
      if (e is BadRequestException || e is NetworkException) {
        emit(state.copyWith(
            message: e is BadRequestException ? e.message : "Vui lòng thử lại!",
            isLoading: false));
        return;
      }
      emit(state.copyWith(
          message: e is BadRequestException ? e.message : "Vui lòng thử lại!",
          isLoading: false));
      rethrow;
    }
  }

  void register(
    String firseName,
    String lastName,
    String phoneNumber,
    String email,
    String password,
    String address,
    DateTime dob,
    int position,
  ) async {
    try {
      emit(state.copyWith(message: null, isLoading: true));
      final res = await _loginRepository.register(
        firstName: firseName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        address: address,
        dob: dob,
        position: position,
      );
      final pre = await SharedPreferences.getInstance();
      await pre.setString("userId", res.id);
      emit(state.copyWith(
        authDone: true,
        isLoading: false,
        user: res,
      ));
    } catch (e) {
      if (e is BadRequestException || e is NetworkException) {
        emit(state.copyWith(
            message: e is BadRequestException ? e.message : "Vui lòng thử lại!",
            isLoading: false));
        return;
      }
      emit(state.copyWith(
          message: e is BadRequestException ? e.message : "Vui lòng thử lại!",
          isLoading: false));
      rethrow;
    }
  }
}
