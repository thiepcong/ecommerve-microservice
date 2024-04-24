import '../api/product_detail_api.dart';

class ProductDetailRepository {
  final ProductDetailApi _api;

  ProductDetailRepository(this._api);

  Future<int> addToCart({
    required int quantity,
    required String type,
    required String productId,
  }) async {
    return _api.addToCart(
      quantity: quantity,
      type: type,
      productId: productId,
    );
  }
}
