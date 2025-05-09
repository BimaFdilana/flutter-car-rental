import 'dart:convert';

class LoginResponseModel {
  final bool success;
  final String message;
  final String token;
  final User user;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(String str) =>
      LoginResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) =>
      LoginResponseModel(
        success: json["success"],
        message: json["message"],
        token: json["token"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "token": token,
        "user": user.toMap(),
      };
}

class User {
  final int id;
  final String name;
  final String username;
  final String noHp;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.noHp,
    required this.role,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        noHp: json["no_hp"],
        role: json["role"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "no_hp": noHp,
        "role": role,
      };
}

class LoginErrorResponseModel {
    final bool success;
    final String message;

    LoginErrorResponseModel({
        required this.success,
        required this.message,
    });

    factory LoginErrorResponseModel.fromJson(String str) => LoginErrorResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoginErrorResponseModel.fromMap(Map<String, dynamic> json) => LoginErrorResponseModel(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
    };
}
