import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_remote_source.dart';
import '../../../core/models/product.dart';
import '../../../core/values/api_url_constant.dart';

class HomeApi extends BaseRemoteSource {
  Future<List<Product>> search({required String key}) async {
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getString("userId");
    final request = dioClient.post(ApiUrlConstants.search(key, userId ?? ''));
    try {
      return callApiWithErrorParser(request).then((value) =>
          (value.data as List).map((e) => Product.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }
}
