import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/order_handle_repository.dart';
import 'order_handle_state.dart';

class OrderHandleCubit extends Cubit<OrderHandleState> {
  OrderHandleCubit(this._repo) : super(const OrderHandleState());

  final OrderHandleRepository _repo;

  void confirmOrder() async {
    try {
      final res = await _repo.confirmOrder();
      emit(state.copyWith(message: res));
    } catch (e) {
      rethrow;
    }
  }
}
