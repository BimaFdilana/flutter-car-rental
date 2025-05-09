import 'dart:convert';

class RegisterRequestModel {
  final String username;
  final String noHp;
  final String password;

  RegisterRequestModel({
    required this.username,
    required this.noHp,
    required this.password,
  });

  factory RegisterRequestModel.fromJson(String str) =>
      RegisterRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      RegisterRequestModel(
        username: json["username"],
        noHp: json["no_hp"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "no_hp": noHp,
        "password": password,
      };
}
