import 'dart:convert';

class BasePesananResponseModel {
  final bool success;
  final String message;
  final Pesanan? pesanan;

  BasePesananResponseModel({
    required this.success,
    required this.message,
    this.pesanan,
  });

  factory BasePesananResponseModel.fromJson(String str) =>
      BasePesananResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BasePesananResponseModel.fromMap(Map<String, dynamic> json) =>
      BasePesananResponseModel(
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        pesanan:
            json["pesanan"] != null ? Pesanan.fromMap(json["pesanan"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "pesanan": pesanan?.toMap(),
      };
}

class Pesanan {
  final int id;
  final int userId;
  final int paketId;
  final String mobil;
  final String? buktiPembayaran;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pesanan({
    required this.id,
    required this.userId,
    required this.paketId,
    required this.mobil,
    this.buktiPembayaran,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pesanan.fromMap(Map<String, dynamic> json) => Pesanan(
        id: json["id"],
        userId: json["user_id"],
        paketId: json["paket_id"],
        mobil: json["mobil"],
        buktiPembayaran: json["bukti_pembayaran"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "paket_id": paketId,
        "mobil": mobil,
        "bukti_pembayaran": buktiPembayaran,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
