import 'dart:convert';

class AllJadwalKasirResponse {
  final bool success;
  final List<Datum> data;

  AllJadwalKasirResponse({
    required this.success,
    required this.data,
  });

  factory AllJadwalKasirResponse.fromJson(String str) =>
      AllJadwalKasirResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllJadwalKasirResponse.fromMap(Map<String, dynamic> json) =>
      AllJadwalKasirResponse(
        success: json["success"] ?? false,
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  final int id;
  final int pesananId;
  final int? instrukturId;
  final DateTime? tanggal;
  final String? waktuMulai;
  final String? waktuSelesai;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pesanan? pesanan;
  final Instruktur? instruktur;

  Datum({
    required this.id,
    required this.pesananId,
    required this.instrukturId,
    required this.tanggal,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.pesanan,
    required this.instruktur,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        pesananId: json["pesanan_id"] ?? 0,
        instrukturId: json["instruktur_id"],
        tanggal:
            json["tanggal"] != null ? DateTime.tryParse(json["tanggal"]) : null,
        waktuMulai: json["waktu_mulai"],
        waktuSelesai: json["waktu_selesai"],
        status: json["status"],
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
        pesanan:
            json["pesanan"] != null ? Pesanan.fromMap(json["pesanan"]) : null,
        instruktur: json["instruktur"] != null
            ? Instruktur.fromMap(json["instruktur"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "pesanan_id": pesananId,
        "instruktur_id": instrukturId,
        "tanggal": tanggal?.toIso8601String(),
        "waktu_mulai": waktuMulai,
        "waktu_selesai": waktuSelesai,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pesanan": pesanan?.toMap(),
        "instruktur": instruktur?.toMap(),
      };
}

class Instruktur {
  final int id;
  final String? name;
  final String? username;
  final String? noHp;
  final String? email;
  final DateTime? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Instruktur({
    required this.id,
    required this.name,
    required this.username,
    required this.noHp,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Instruktur.fromJson(String str) =>
      Instruktur.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Instruktur.fromMap(Map<String, dynamic> json) => Instruktur(
        id: json["id"] ?? 0,
        name: json["name"],
        username: json["username"],
        noHp: json["no_hp"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] != null
            ? DateTime.tryParse(json["email_verified_at"])
            : null,
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "no_hp": noHp,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Pesanan {
  final int id;
  final int userId;
  final int paketId;
  final String? mobil;
  final String? buktiPembayaran;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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

  factory Pesanan.fromMap(Map<String, dynamic> json) => Pesanan(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        paketId: json["paket_id"] ?? 0,
        mobil: json["mobil"],
        buktiPembayaran: json["bukti_pembayaran"],
        status: json["status"],
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "paket_id": paketId,
        "mobil": mobil,
        "bukti_pembayaran": buktiPembayaran,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ChangeJadwalKasirResponse {
  final bool success;
  final Data data;

  ChangeJadwalKasirResponse({
    required this.success,
    required this.data,
  });

  factory ChangeJadwalKasirResponse.fromJson(String str) =>
      ChangeJadwalKasirResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChangeJadwalKasirResponse.fromMap(Map<String, dynamic> json) =>
      ChangeJadwalKasirResponse(
        success: json["success"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": data.toMap(),
      };
}

class Data {
  final int id;
  final int pesananId;
  final int instrukturId;
  final DateTime tanggal;
  final String waktuMulai;
  final String waktuSelesai;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.pesananId,
    required this.instrukturId,
    required this.tanggal,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        pesananId: json["pesanan_id"],
        instrukturId: json["instruktur_id"],
        tanggal: DateTime.parse(json["tanggal"]),
        waktuMulai: json["waktu_mulai"],
        waktuSelesai: json["waktu_selesai"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "pesanan_id": pesananId,
        "instruktur_id": instrukturId,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "waktu_mulai": waktuMulai,
        "waktu_selesai": waktuSelesai,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
