import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_remote_source.dart';
import '../../../core/models/order_model.dart';
import '../../../core/values/api_url_constant.dart';

class PurchaseApi extends BaseRemoteSource {
  Future<List<OrderModel>> getOrderByUser() async {
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getString("userId");
    final request = dioClient.get(ApiUrlConstants.getOrderByUser(userId ?? ''));
    try {
      return callApiWithErrorParser(request).then((value) =>
          (value.data as List).map((e) => OrderModel.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<String> cancelOrder(int orderId) async {
    final request = dioClient.put(ApiUrlConstants.cancelOrder(orderId));
    try {
      return callApiWithErrorParser(request)
          .then((value) => value.data['message']);
    } catch (e) {
      rethrow;
    }
  }
}
