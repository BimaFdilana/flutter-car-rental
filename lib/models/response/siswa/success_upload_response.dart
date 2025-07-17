import 'dart:convert';

class SuccessUploadResponseModel {
  final bool success;
  final String message;
  final Pesanan pesanan;

  SuccessUploadResponseModel({
    required this.success,
    required this.message,
    required this.pesanan,
  });

  factory SuccessUploadResponseModel.fromJson(String str) =>
      SuccessUploadResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuccessUploadResponseModel.fromMap(Map<String, dynamic> json) =>
      SuccessUploadResponseModel(
        success: json["success"],
        message: json["message"],
        pesanan: Pesanan.fromMap(json["pesanan"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "pesanan": pesanan.toMap(),
      };
}

class Pesanan {
  final int id;
  final int userId;
  final int paketId;
  final String mobil;
  final String buktiPembayaran;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pesanan({
    required this.id,
    required this.userId,
    required this.paketId,
    required this.mobil,
    required this.buktiPembayaran,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pesanan.fromJson(String str) => Pesanan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  // ✅ DIUBAH DI SINI
  factory Pesanan.fromMap(Map<String, dynamic> json) => Pesanan(
        // Menggunakan int.parse() untuk mencegah error tipe data
        id: int.parse(json["id"].toString()),
        userId: int.parse(json["user_id"].toString()),
        paketId: int.parse(json["paket_id"].toString()),

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
        "created_at": createdAt.toIso8601String(), // Gunakan toIso8601String()
        "updated_at": updatedAt.toIso8601String(), // Gunakan toIso8601String()
      };
}
