import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_remote_source.dart';
import '../../../core/values/api_url_constant.dart';

class OrderHandleApi extends BaseRemoteSource {
  Future<String> confirmOrder() async {
    final pre = await SharedPreferences.getInstance();
    final orderId = pre.getInt("orderId") ?? -1;
    final userId = pre.getString("userId") ?? '';
    final productId = pre.getString("productId") ?? '';
    final request = dioClient
        .put(ApiUrlConstants.paymentSuccessOrder(orderId, userId, productId));
    try {
      return callApiWithErrorParser(request)
          .then((value) => value.data['message']);
    } catch (e) {
      rethrow;
    }
  }
}
