class User {
  late final String id;
  late final String username;
  late final String fullName;
  late final String role;
  late final String email;
  late final String password;
  late final String token;

  User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.role,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['name'],
      fullName: json['full_name'],
      role: json['role'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"username": username, "full_name":fullName, "email": email, "role": role, "password": password};
  }
}
