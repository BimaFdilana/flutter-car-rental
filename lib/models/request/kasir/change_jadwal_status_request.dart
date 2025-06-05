import 'dart:convert';

class ChangeJadwalKasirRequest {
  final int id;
  final String status;

  ChangeJadwalKasirRequest({
    required this.id,
    required this.status,
  });

  factory ChangeJadwalKasirRequest.fromJson(String str) =>
      ChangeJadwalKasirRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChangeJadwalKasirRequest.fromMap(Map<String, dynamic> json) =>
      ChangeJadwalKasirRequest(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
      };
}
