import 'package:ecommerce_flutter/app/core/models/address.dart';
import 'package:ecommerce_flutter/app/core/models/carrier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/cart_item_model.dart';
import '../repository/order_repository.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._repo) : super(const OrderState());

  final OrderRepository _repo;

  void init(List<CartItemModel> carts) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.getAllAddress();
      final res2 = await _repo.getAllCarrier();
      emit(state.copyWith(
        carts: carts,
        addresses: res,
        carriers: res2,
        isLoading: false,
        currentAddress: res.isNotEmpty ? res.first : null,
        currentCarrier: res2.isNotEmpty ? res2.first : null,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }

  void setCurrentAddress(Address e) {
    emit(state.copyWith(currentAddress: e));
  }

  void setCurrentCarrier(Carrier e) {
    emit(state.copyWith(currentCarrier: e));
  }
}
