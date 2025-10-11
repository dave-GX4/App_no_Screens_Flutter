import 'dart:convert';

class User {
  final String firtsname;
  final String lastname;
  final String email;
  final String password;

  const User({
    required this.firtsname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'firtsname': firtsname,
      'lastname': lastname,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firtsname: map['firtsname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}