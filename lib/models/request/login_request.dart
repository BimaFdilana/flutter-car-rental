import 'dart:convert';

class LoginRequestModel {
  final String auth;
  final String password;

  LoginRequestModel({
    required this.auth,
    required this.password,
  });

  factory LoginRequestModel.fromJson(String str) =>
      LoginRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromMap(Map<String, dynamic> json) =>
      LoginRequestModel(
        auth: json["auth"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "auth": auth,
        "password": password,
      };
}
