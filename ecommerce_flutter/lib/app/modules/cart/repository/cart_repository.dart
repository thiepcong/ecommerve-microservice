import '../../../core/models/cart_response.dart';
import '../api/cart_api.dart';

class CartRepository {
  final CartApi _api;

  CartRepository(this._api);

  Future<CartResponse> getAllCartItem() async {
    return _api.getAllCartItem();
  }

  Future<int> updateCartItem({
    required int quantity,
    required String type,
    required String productId,
  }) async {
    return _api.updateCartItem(
      quantity: quantity,
      type: type,
      productId: productId,
    );
  }

  Future<String> deleteCartItem({required String productId}) async {
    return _api.deleteCartItem(productId: productId);
  }
}
