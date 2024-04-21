import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/cart_item_model.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const CartState._();

  const factory CartState({
    @Default(false) bool isLoading,
    @Default([]) List<CartItemModel> carts,
    String? message,
    Error? error,
  }) = _CartState;
}
