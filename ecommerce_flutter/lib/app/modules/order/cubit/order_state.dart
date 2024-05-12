import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/address.dart';
import '../../../core/models/carrier.dart';
import '../../../core/models/cart_item_model.dart';

part 'order_state.freezed.dart';

@freezed
class OrderState with _$OrderState {
  const OrderState._();

  const factory OrderState({
    @Default([]) List<Address> addresses,
    Address? currentAddress,
    @Default([]) List<Carrier> carriers,
    Carrier? currentCarrier,
    @Default([]) List<CartItemModel> carts,
    @Default(false) bool isLoading,
    String? message,
    Error? error,
  }) = _OrderState;
}
