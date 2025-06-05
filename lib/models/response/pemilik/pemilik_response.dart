import 'dart:convert';

class PemilikDataResponse {
  final bool success;
  final String message;
  final Data data;

  PemilikDataResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PemilikDataResponse.fromJson(String str) =>
      PemilikDataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PemilikDataResponse.fromMap(Map<String, dynamic> json) =>
      PemilikDataResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  final List<Success> success;

  Data({
    required this.success,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        success:
            List<Success>.from(json["success"].map((x) => Success.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": List<dynamic>.from(success.map((x) => x.toMap())),
      };
}

class Success {
  final int id;
  final int userId;
  final int paketId;
  final String mobil;
  final String buktiPembayaran;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final Paket paket;
  final List<Jadwal> jadwal;

  Success({
    required this.id,
    required this.userId,
    required this.paketId,
    required this.mobil,
    required this.buktiPembayaran,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.paket,
    required this.jadwal,
  });

  factory Success.fromJson(String str) => Success.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        id: json["id"],
        userId: json["user_id"],
        paketId: json["paket_id"],
        mobil: json["mobil"],
        buktiPembayaran: json["bukti_pembayaran"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromMap(json["user"]),
        paket: Paket.fromMap(json["paket"]),
        jadwal: List<Jadwal>.from(json["jadwal"].map((x) => Jadwal.fromMap(x))),
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
        "user": user.toMap(),
        "paket": paket.toMap(),
        "jadwal": List<dynamic>.from(jadwal.map((x) => x.toMap())),
      };
}

class Jadwal {
  final int id;
  final int pesananId;
  final int instrukturId;
  final DateTime tanggal;
  final String waktuMulai;
  final String waktuSelesai;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Jadwal({
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

  factory Jadwal.fromJson(String str) => Jadwal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Jadwal.fromMap(Map<String, dynamic> json) => Jadwal(
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

class Paket {
  final int id;
  final String namaPaket;
  final String jumlahJam;
  final String noRekening;
  final String deskripsi;
  final String harga;
  final DateTime createdAt;
  final DateTime updatedAt;

  Paket({
    required this.id,
    required this.namaPaket,
    required this.jumlahJam,
    required this.noRekening,
    required this.deskripsi,
    required this.harga,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Paket.fromJson(String str) => Paket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Paket.fromMap(Map<String, dynamic> json) => Paket(
        id: json["id"],
        namaPaket: json["nama_paket"],
        jumlahJam: json["jumlah_jam"],
        noRekening: json["no_rekening"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nama_paket": namaPaket,
        "jumlah_jam": jumlahJam,
        "no_rekening": noRekening,
        "deskripsi": deskripsi,
        "harga": harga,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class User {
  final int id;
  final String name;
  final String username;
  final String noHp;
  final String email;
  final DateTime emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.noHp,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        noHp: json["no_hp"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "no_hp": noHp,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
