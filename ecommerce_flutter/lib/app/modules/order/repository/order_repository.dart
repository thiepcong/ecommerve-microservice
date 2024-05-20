import '../../../core/models/address.dart';
import '../../../core/models/carrier.dart';
import '../../../core/models/cart_item_model.dart';
import '../../../core/models/payment_method.dart';
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

  Future<List<PaymentMethod>> getAllPaymentMethod() async {
    return _api.getAllPaymentMethod();
  }

  Future<int> orderHandle({
    required List<CartItemModel> carts,
    required PaymentMethod paymentMethod,
    required Carrier carrier,
    required Address address,
  }) async {
    return _api.orderHandle(
      carts: carts,
      paymentMethod: paymentMethod,
      carrier: carrier,
      address: address,
    );
  }
}
