class Carrier {
  final int id;
  final String name;
  final double price;
  final String address;
  final String email;
  final String mobile;
  final String des;

  Carrier({
    this.id = -1,
    required this.name,
    required this.price,
    required this.address,
    required this.email,
    required this.mobile,
    required this.des,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'address': address,
      'email': email,
      'mobile': mobile,
      'des': des,
    };
  }

  factory Carrier.fromJson(Map<String, dynamic> map) {
    return Carrier(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
      address: map['address'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      des: map['des'] as String,
    );
  }
}
