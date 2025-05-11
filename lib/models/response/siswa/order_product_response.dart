import 'dart:convert';

class OrderProdukResponseModel {
  final bool success;
  final String message;
  final Pesanan pesanan;

  OrderProdukResponseModel({
    required this.success,
    required this.message,
    required this.pesanan,
  });

  factory OrderProdukResponseModel.fromJson(String str) =>
      OrderProdukResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderProdukResponseModel.fromMap(Map<String, dynamic> json) =>
      OrderProdukResponseModel(
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
  final int paketId;
  final int userId;
  final String mobil;
  final String status;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Pesanan({
    required this.paketId,
    required this.userId,
    required this.mobil,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Pesanan.fromJson(String str) => Pesanan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pesanan.fromMap(Map<String, dynamic> json) => Pesanan(
        paketId: json["paket_id"],
        userId: json["user_id"],
        mobil: json["mobil"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "paket_id": paketId,
        "user_id": userId,
        "mobil": mobil,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
