import '../../../core/models/order_model.dart';
import '../api/purchase_api.dart';

class PurchaseRepository {
  final PurchaseApi _api;

  PurchaseRepository(this._api);

  Future<List<OrderModel>> getOrderByUser() async {
    return _api.getOrderByUser();
  }

  Future<String> cancelOrder(int orderId) async {
    return _api.cancelOrder(orderId);
  }
}
