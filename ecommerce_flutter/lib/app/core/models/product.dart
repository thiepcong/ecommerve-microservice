class Product {
  final String id;
  final String title;
  final String image;
  final double price;
  final String des;
  final int quantity;
  final String type;

  Product({
    this.id = '',
    required this.title,
    required this.image,
    required this.price,
    required this.des,
    this.quantity = 0,
    this.type = '',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'image': image,
      'price': price,
      'des': des,
      'quantity': quantity,
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null
          ? map['id'] as String
          : map['book_id'] != null
              ? map['book_id'] as String
              : map['mobile_id'] != null
                  ? map['mobile_id'] as String
                  : map['clothes_id'] != null
                      ? map['clothes_id'] as String
                      : "",
      title: map['title'] as String,
      image: map['image'] as String,
      price: map['price'] as double,
      des: map['des'] as String,
      quantity: map['quantity'] as int,
      type: map.containsKey('book_id')
          ? 'book'
          : map.containsKey("mobile_id")
              ? 'mobile'
              : "clothes",
    );
  }
}
