class PaymentMethod {
  final int id;
  final String name;
  final bool isActive;

  PaymentMethod({this.id = -1, required this.name, required this.isActive});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'is_active': isActive,
    };
  }

  factory PaymentMethod.fromJson(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] as int,
      name: map['name'] as String,
      isActive: map['is_active'] as bool,
    );
  }
}
