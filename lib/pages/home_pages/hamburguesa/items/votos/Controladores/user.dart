class User {
  int id;
  String? name;
  String? email;
  String? password;
  // String? token;

  User({required this.id, this.name, this.email, this.password});

  // function to convert json data to user model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id_user'] as int,
      name: json['nombre'],
      email: json['email'],
      password: json['password'],
      // token: json['token']
    );
  }
}
