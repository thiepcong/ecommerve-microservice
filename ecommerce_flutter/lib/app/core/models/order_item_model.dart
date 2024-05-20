import 'product.dart';

class OrderItemModel {
  final int quantity;
  final double price;
  final double sale;
  final Product product;

  OrderItemModel({
    required this.quantity,
    required this.price,
    required this.sale,
    required this.product,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'quantity': quantity,
      'price': price,
      'sale': sale,
      'product': product.toJson(),
    };
  }

  factory OrderItemModel.fromJson(Map<String, dynamic> map) {
    return OrderItemModel(
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      sale: map['sale'] as double,
      product: Product.fromJson(map['product'] as Map<String, dynamic>),
    );
  }
}
