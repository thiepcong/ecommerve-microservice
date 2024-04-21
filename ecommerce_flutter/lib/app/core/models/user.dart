class User {
  final int id;
  final String username;
  final String name;

  User({
    required this.id,
    required this.username,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      username: map['username'] as String,
      name: map['name'] as String,
    );
  }
}
