import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../network/exceptions/bad_request_exception.dart';
import '../../../network/exceptions/network_exception.dart';
import '../repository/login_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginRepository) : super(const LoginState());

  final LoginRepository _loginRepository;

  void login(String username, String password) async {
    try {
      emit(state.copyWith(message: null, isLoading: true));
      final res =
          await _loginRepository.login(usename: username, password: password);
      final pre = await SharedPreferences.getInstance();
      await pre.setInt("userId", res.id);
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

  void register(String name, String username, String password) async {
    try {
      emit(state.copyWith(message: null, isLoading: true));
      final res = await _loginRepository.register(
        name: name,
        usename: username,
        password: password,
      );
      final pre = await SharedPreferences.getInstance();
      await pre.setInt("userId", res.id);
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
