import '../../../core/models/address.dart';
import '../../../core/models/carrier.dart';
import '../api/order_api.dart';

class OrderRepository {
  final OrderApi _api;

  OrderRepository(this._api);

  Future<List<Address>> getAllAddress() async {
    return _api.getAllAddress();
  }

  Future<List<Carrier>> getAllCarrier() async {
    return _api.getAllCarrier();
  }
}
