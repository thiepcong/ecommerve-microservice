import 'product.dart';

class CartItemModel {
  final int quantity;
  final bool isChoose;
  final Product product;

  CartItemModel({
    required this.quantity,
    required this.product,
    this.isChoose = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'product': product.toJson(),
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      quantity: map['quantity'] as int,
      product: Product.fromJson(map['product'] as Map<String, dynamic>),
    );
  }

  CartItemModel copyWith({
    int? quantity,
    bool? isChoose,
    Product? product,
  }) {
    return CartItemModel(
      quantity: quantity ?? this.quantity,
      isChoose: isChoose ?? this.isChoose,
      product: product ?? this.product,
    );
  }
}
