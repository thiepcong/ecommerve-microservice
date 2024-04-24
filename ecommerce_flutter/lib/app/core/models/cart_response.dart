import 'cart_item_model.dart';

class CartResponse {
  final List<CartItemModel> cartItems;
  final double cartTotal;

  CartResponse({required this.cartItems, required this.cartTotal});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
      'cartTotal': cartTotal,
    };
  }

  factory CartResponse.fromJson(Map<String, dynamic> map) {
    return CartResponse(
      cartItems: List<CartItemModel>.from(
        (map['cart_items'] as List).map<CartItemModel>(
          (x) => CartItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      cartTotal: map['cart_total'] as double,
    );
  }
}
