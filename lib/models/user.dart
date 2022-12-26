class User {
  final String email;
  final int id;

  User({required this.email, required this.id});

  factory User.fromJson(dynamic json) {
    return User(id: json['id'], email: json['email']);
  }
}
