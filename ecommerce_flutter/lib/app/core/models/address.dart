class Address {
  final int id;
  final String fname;
  final String lname;
  final String email;
  final String mobile;
  final String address;

  Address({
    this.id = -1,
    required this.fname,
    required this.lname,
    required this.email,
    required this.mobile,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fname': fname,
      'lname': lname,
      'email': email,
      'mobile': mobile,
      'address': address,
      'is_active': true,
    };
  }

  factory Address.fromJson(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as int,
      fname: map['fname'] as String,
      lname: map['lname'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      address: map['address'] as String,
    );
  }
}
