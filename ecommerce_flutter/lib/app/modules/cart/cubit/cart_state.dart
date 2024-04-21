import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const CartState._();

  const factory CartState({
    @Default(false) bool isLoading,
    String? message,
    Error? error,
  }) = _CartState;
}
