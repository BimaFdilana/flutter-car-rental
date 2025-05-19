import 'dart:convert';

class UpdateStatusResponse {
  final bool success;
  final String message;

  UpdateStatusResponse({
    required this.success,
    required this.message,
  });

  factory UpdateStatusResponse.fromRawJson(String str) =>
      UpdateStatusResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateStatusResponse.fromJson(Map<String, dynamic> json) =>
      UpdateStatusResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
