class User {
  late final String id;
  late final String name;
  late final String role;
  late final String email;
  late final String password;
  late final String token;

  User({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['_id'],
        name: json['name'],
        role: json['role'],
        email: json['email'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return{"name":name, "email":email, "role":role, "password":password};
  }
}
