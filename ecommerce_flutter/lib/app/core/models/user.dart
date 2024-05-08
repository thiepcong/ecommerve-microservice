import 'package:intl/intl.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String password;
  final String address;
  final DateTime dob;
  final int position;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.address,
    required this.dob,
    required this.password,
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
      'address': address,
      'dob': dob,
      'position': position,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      firstName: map['fname'] as String,
      lastName: map['lname'] as String,
      mobile: map['mobile'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      address: map['address'] as String,
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
    String? address,
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
      address: address ?? this.address,
      dob: dob ?? this.dob,
      position: position ?? this.position,
    );
  }
}
