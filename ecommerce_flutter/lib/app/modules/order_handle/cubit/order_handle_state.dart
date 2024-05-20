import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_handle_state.freezed.dart';

@freezed
class OrderHandleState with _$OrderHandleState {
  const OrderHandleState._();

  const factory OrderHandleState({
    String? message,
    Error? error,
  }) = _OrderHandleState;
}
