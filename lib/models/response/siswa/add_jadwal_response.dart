import 'dart:convert';

class SuccessAddJadwalResponseModel {
  final bool success;
  final String message;

  SuccessAddJadwalResponseModel({
    required this.success,
    required this.message,
  });

  factory SuccessAddJadwalResponseModel.fromJson(String str) =>
      SuccessAddJadwalResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuccessAddJadwalResponseModel.fromMap(Map<String, dynamic> json) =>
      SuccessAddJadwalResponseModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
      };
}

class ErrorAddJadwalResponseModel {
  final bool success;
  final String message;
  final double sisaJam;

  ErrorAddJadwalResponseModel({
    required this.success,
    required this.message,
    required this.sisaJam,
  });

  factory ErrorAddJadwalResponseModel.fromJson(String str) =>
      ErrorAddJadwalResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ErrorAddJadwalResponseModel.fromMap(Map<String, dynamic> json) =>
      ErrorAddJadwalResponseModel(
        success: json["success"],
        message: json["message"] is String
            ? json["message"]
            : jsonEncode(json["message"]), // ubah Map ke string JSON
        sisaJam: json["sisa_jam"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "sisa_jam": sisaJam,
      };
}
