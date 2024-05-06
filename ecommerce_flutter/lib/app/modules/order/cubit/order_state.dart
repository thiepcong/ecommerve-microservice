import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_state.freezed.dart';

@freezed
class OrderState with _$OrderState {
  const OrderState._();

  const factory OrderState({
    @Default(false) bool isLoading,
    String? message,
    Error? error,
  }) = _OrderState;
}
