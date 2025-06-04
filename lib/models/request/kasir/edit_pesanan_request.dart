import 'dart:convert';

class EditPesananRequest {
  final int idPesanan;
  final String status;

  EditPesananRequest({
    required this.idPesanan,
    required this.status,
  });

  factory EditPesananRequest.fromRawJson(String str) =>
      EditPesananRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EditPesananRequest.fromJson(Map<String, dynamic> json) =>
      EditPesananRequest(
        idPesanan: json["id_pesanan"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_pesanan": idPesanan,
        "status": status,
      };
}
