import 'dart:convert';

class UpdateRequestStatus {
  final int idJadwal;
  final String status;

  UpdateRequestStatus({
    required this.idJadwal,
    required this.status,
  });

  factory UpdateRequestStatus.fromRawJson(String str) =>
      UpdateRequestStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateRequestStatus.fromJson(Map<String, dynamic> json) =>
      UpdateRequestStatus(
        idJadwal: json["id_jadwal"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_jadwal": idJadwal,
        "status": status,
      };
}
