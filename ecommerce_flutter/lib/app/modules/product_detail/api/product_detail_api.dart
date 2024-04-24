import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_remote_source.dart';
import '../../../core/values/api_url_constant.dart';

class ProductDetailApi extends BaseRemoteSource {
  Future<int> addToCart({
    required int quantity,
    required String type,
    required String productId,
  }) async {
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getInt("userId");
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
}
