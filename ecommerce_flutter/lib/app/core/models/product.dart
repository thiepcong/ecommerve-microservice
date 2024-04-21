class Product {
  final String title;
  final String image;
  final double price;
  final String des;

  Product({
    required this.title,
    required this.image,
    required this.price,
    required this.des,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'image': image,
      'price': price,
      'des': des,
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      title: map['title'] as String,
      image: map['image'] as String,
      price: map['price'] as double,
      des: map['des'] as String,
    );
  }
}
