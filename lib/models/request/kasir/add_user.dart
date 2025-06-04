import 'dart:convert';

class UserRequest {
  final String username;
  final String noHp;
  final String password;
  final String role;

  UserRequest({
    required this.username,
    required this.noHp,
    required this.password,
    required this.role,
  });

  factory UserRequest.fromJson(String str) =>
      UserRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserRequest.fromMap(Map<String, dynamic> json) => UserRequest(
        username: json["username"],
        noHp: json["no_hp"],
        password: json["password"],
        role: json["role"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "no_hp": noHp,
        "password": password,
        "role": role,
      };
}
