import 'dart:convert';

class RegisterResponseModel {
  final bool success;
  final String message;
  final User user;
  final String token;

  RegisterResponseModel({
    required this.success,
    required this.message,
    required this.user,
    required this.token,
  });

  factory RegisterResponseModel.fromJson(String str) =>
      RegisterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      RegisterResponseModel(
        success: json["success"],
        message: json["message"],
        user: User.fromMap(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "user": user.toMap(),
        "token": token,
      };
}

class User {
  final String username;
  final String noHp;
  final String name;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  User({
    required this.username,
    required this.noHp,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        username: json["username"],
        noHp: json["no_hp"],
        name: json["name"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "no_hp": noHp,
        "name": name,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}


class RegisterErrorResponseModel {
    final bool success;
    final Message message;

    RegisterErrorResponseModel({
        required this.success,
        required this.message,
    });

    factory RegisterErrorResponseModel.fromJson(String str) => RegisterErrorResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegisterErrorResponseModel.fromMap(Map<String, dynamic> json) => RegisterErrorResponseModel(
        success: json["success"],
        message: Message.fromMap(json["message"]),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message.toMap(),
    };
}

class Message {
    final List<String> username;
    final List<String> noHp;
    final List<String> password;

    Message({
        required this.username,
        required this.noHp,
        required this.password,
    });

    factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Message.fromMap(Map<String, dynamic> json) => Message(
        username: List<String>.from(json["username"].map((x) => x)),
        noHp: List<String>.from(json["no_hp"].map((x) => x)),
        password: List<String>.from(json["password"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "username": List<dynamic>.from(username.map((x) => x)),
        "no_hp": List<dynamic>.from(noHp.map((x) => x)),
        "password": List<dynamic>.from(password.map((x) => x)),
    };
}
