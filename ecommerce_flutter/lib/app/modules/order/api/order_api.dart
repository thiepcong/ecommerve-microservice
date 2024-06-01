import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_remote_source.dart';
import '../../../core/models/address.dart';
import '../../../core/models/carrier.dart';
import '../../../core/models/cart_item_model.dart';
import '../../../core/models/payment_method.dart';
import '../../../core/values/api_url_constant.dart';

class OrderApi extends BaseRemoteSource {
  Future<List<Address>> getAllAddress() async {
    final request = dioClient.get(ApiUrlConstants.address);
    try {
      return callApiWithErrorParser(request).then((value) =>
          (value.data as List).map((e) => Address.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Carrier>> getAllCarrier() async {
    final request = dioClient.get(ApiUrlConstants.carrier);
    try {
      return callApiWithErrorParser(request).then((value) =>
          (value.data as List).map((e) => Carrier.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PaymentMethod>> getAllPaymentMethod() async {
    final request = dioClient.get(ApiUrlConstants.paymentMethod);
    try {
      return callApiWithErrorParser(request).then((value) =>
          (value.data as List).map((e) => PaymentMethod.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<int> orderHandle({
    required List<CartItemModel> carts,
    required PaymentMethod paymentMethod,
    required Carrier carrier,
    required Address address,
  }) async {
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getString("userId");
    final request = dioClient.post(ApiUrlConstants.addOrder, data: {
      "order": {
        "user_id": userId,
        "order_items": carts
            .map((e) => {
                  "product_id": e.product.id,
                  "type": e.product.type,
                  "price": e.product.price,
                  "quantity": e.quantity,
                  "sale": e.product.sale
                })
            .toList(),
      },
      "payment": {
        "payment_method": paymentMethod.id,
      },
      "shipment": {
        "carrier": carrier.id,
        "shipment_info": address.id,
        "transaction": 1,
      },
    });
    try {
      final pre = await SharedPreferences.getInstance();
      await pre.setString("productId", carts.first.product.id);
      return callApiWithErrorParser(request).then((value) => value.data['id']);
    } catch (e) {
      rethrow;
    }
  }
}
