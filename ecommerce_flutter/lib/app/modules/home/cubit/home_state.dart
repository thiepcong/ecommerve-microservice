import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/product.dart';
import '../../../core/models/user.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<Product> products,
    String? filter,
    User? user,
    String? message,
    Error? error,
  }) = _HomeState;
}
