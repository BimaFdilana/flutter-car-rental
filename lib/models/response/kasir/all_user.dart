import 'dart:convert';

class UserResponse {
  final bool success;
  final List<Datum> data;

  UserResponse({
    required this.success,
    required this.data,
  });

  factory UserResponse.fromJson(String str) =>
      UserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  final int id;
  final String name;
  final String username;
  final String noHp;
  final String? email;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Role> roles;

  Datum({
    required this.id,
    required this.name,
    required this.username,
    required this.noHp,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: int.tryParse(json["id"].toString()) ?? 0,
        name: json["name"]?.toString() ?? '',
        username: json["username"]?.toString() ?? '',
        noHp: json["no_hp"]?.toString() ?? '',
        email: json["email"]?.toString(),
        emailVerifiedAt: json["email_verified_at"] != null
            ? DateTime.tryParse(json["email_verified_at"].toString())
            : null,
        createdAt:
            DateTime.tryParse(json["created_at"].toString()) ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"].toString()) ?? DateTime.now(),
        roles: (json["roles"] as List<dynamic>? ?? [])
            .map((x) => Role.fromMap(x))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "no_hp": noHp,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "roles": List<dynamic>.from(roles.map((x) => x.toMap())),
      };
}

class Role {
  final int id;
  final String name;
  final String guardName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        id: int.tryParse(json["id"].toString()) ?? 0,
        name: json["name"]?.toString() ?? '',
        guardName: json["guard_name"]?.toString() ?? '',
        createdAt:
            DateTime.tryParse(json["created_at"].toString()) ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"].toString()) ?? DateTime.now(),
        pivot: Pivot.fromMap(json["pivot"] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toMap(),
      };
}

class Pivot {
  final String modelType;
  final int modelId;
  final int roleId;

  Pivot({
    required this.modelType,
    required this.modelId,
    required this.roleId,
  });

  factory Pivot.fromJson(String str) => Pivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
        modelType: json["model_type"]?.toString() ?? '',
        modelId: int.tryParse(json["model_id"].toString()) ?? 0,
        roleId: int.tryParse(json["role_id"].toString()) ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "model_type": modelType,
        "model_id": modelId,
        "role_id": roleId,
      };
}

class AddUserResponse {
  final bool success;
  final String message;
  final User user;

  AddUserResponse({
    required this.success,
    required this.message,
    required this.user,
  });

  factory AddUserResponse.fromJson(String str) =>
      AddUserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddUserResponse.fromMap(Map<String, dynamic> json) => AddUserResponse(
        success: json["success"],
        message: json["message"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "user": user.toMap(),
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
        username: json["username"]?.toString() ?? '',
        noHp: json["no_hp"]?.toString() ?? '',
        name: json["name"]?.toString() ?? '',
        updatedAt:
            DateTime.tryParse(json["updated_at"].toString()) ?? DateTime.now(),
        createdAt:
            DateTime.tryParse(json["created_at"].toString()) ?? DateTime.now(),
        id: int.tryParse(json["id"].toString()) ?? 0,
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

class DeletedUserResponse {
  final bool success;
  final String message;

  DeletedUserResponse({
    required this.success,
    required this.message,
  });

  factory DeletedUserResponse.fromJson(String str) =>
      DeletedUserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeletedUserResponse.fromMap(Map<String, dynamic> json) =>
      DeletedUserResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
      };
}
