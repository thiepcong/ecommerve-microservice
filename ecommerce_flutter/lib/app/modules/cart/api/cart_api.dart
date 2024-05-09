import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_remote_source.dart';
import '../../../core/models/cart_response.dart';
import '../../../core/values/api_url_constant.dart';

class CartApi extends BaseRemoteSource {
  Future<CartResponse> getAllCartItem() async {
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getString("userId");
    final request = dioClient
        .post(ApiUrlConstants.getAllCartItem, data: {"user_id": userId});
    try {
      return callApiWithErrorParser(request)
          .then((value) => CartResponse.fromJson(value.data));
    } catch (e) {
      rethrow;
    }
  }

  Future<int> updateCartItem({
    required int quantity,
    required String type,
    required String productId,
  }) async {
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getString("userId");
    final request = dioClient.post(ApiUrlConstants.addToCart, data: {
      "user_id": userId,
      "quantity": quantity,
      "type": type,
      "product_id": productId,
    });
    try {
      return callApiWithErrorParser(request)
          .then((value) => value.data['quantity']);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteCartItem({required String productId}) async {
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getString("userId");
    final request = dioClient
        .delete(ApiUrlConstants.deleteCartItem(userId ?? '', productId));
    try {
      return callApiWithErrorParser(request)
          .then((value) => "Đã xoá thành công");
    } catch (e) {
      rethrow;
    }
  }
}
