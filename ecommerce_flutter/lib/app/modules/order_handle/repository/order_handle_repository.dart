import '../api/order_handle_api.dart';

class OrderHandleRepository {
  final OrderHandleApi _api;

  OrderHandleRepository(this._api);

  Future<String> confirmOrder() async {
    return _api.confirmOrder();
  }
}
