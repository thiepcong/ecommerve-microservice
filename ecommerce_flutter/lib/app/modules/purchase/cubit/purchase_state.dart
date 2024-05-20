import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/order_model.dart';
import '../../../core/models/user.dart';

part 'purchase_state.freezed.dart';

@freezed
class PurchaseState with _$PurchaseState {
  const PurchaseState._();

  const factory PurchaseState({
    @Default(false) bool isLoading,
    @Default([]) List<OrderModel> orders,
    User? user,
    String? message,
    Error? error,
  }) = _PurchaseState;
}
