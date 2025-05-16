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
