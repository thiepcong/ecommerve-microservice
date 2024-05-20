import 'package:intl/intl.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String password;
  final String province;
  final String district;
  final String ward;
  final String street;
  final DateTime dob;
  final int position;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.password,
    required this.province,
    required this.district,
    required this.ward,
    required this.street,
    required this.dob,
    required this.position,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'email': email,
      'password': password,
      'dob': dob,
      'position': position,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      firstName: map['full_name']['fname'] as String,
      lastName: map['full_name']['lname'] as String,
      mobile: map['mobile'] as String,
      email: map['account']['email'] as String,
      password: map['account']['password'] as String,
      province: map['address']['province'] as String,
      district: map['address']['district'] as String,
      street: map['address']['street'] as String,
      ward: map['address']['ward'] as String,
      dob: DateFormat('yyyy-MM-dd').parse(map['dob'] as String),
      position: map['position'] as int,
    );
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? mobile,
    String? email,
    String? password,
    String? province,
    String? district,
    String? ward,
    String? street,
    DateTime? dob,
    int? position,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      password: password ?? this.password,
      province: province ?? this.province,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      street: street ?? this.street,
      dob: dob ?? this.dob,
      position: position ?? this.position,
    );
  }
}
