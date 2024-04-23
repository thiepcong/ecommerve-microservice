import '../../../core/models/product.dart';
import '../api/home_api.dart';

class HomeRepository {
  final HomeApi _api;

  HomeRepository(this._api);

  Future<List<Product>> search({required String key}) async {
    return _api.search(key: key);
  }
}
