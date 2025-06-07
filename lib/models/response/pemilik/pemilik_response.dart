
class PemilikDataResponse {
  final bool success;
  final String message;
  final Data data;

  PemilikDataResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PemilikDataResponse.fromMap(Map<String, dynamic> json) =>
      PemilikDataResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        data: Data.fromMap(json["data"] ?? {}),
      );
}

class Data {
  final List<Success> success;

  Data({required this.success});

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        success: (json["success"] as List<dynamic>? ?? [])
            .map((x) => Success.fromMap(x))
            .toList(),
      );
}

class Success {
  final int id;
  final int userId;
  final int paketId;
  final String? mobil;
  final String? buktiPembayaran;
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

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        paketId: json["paket_id"] ?? 0,
        mobil: json["mobil"],
        buktiPembayaran: json['bukti_pembayaran'] as String?,
        status: json["status"] ?? '',
        createdAt:
            DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"] ?? '') ?? DateTime.now(),
        user: User.fromMap(json["user"] ?? {}),
        paket: Paket.fromMap(json["paket"] ?? {}),
        jadwal: (json["jadwal"] as List<dynamic>? ?? [])
            .map((x) => Jadwal.fromMap(x))
            .toList(),
      );
}

class User {
  final int id;
  final String name;
  final String username;
  final String noHp;
  final String email;
  final DateTime? emailVerifiedAt;
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

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        username: json["username"] ?? '',
        noHp: json["no_hp"] ?? '',
        email: json["email"] ?? '',
        emailVerifiedAt: json["email_verified_at"] != null
            ? DateTime.tryParse(json["email_verified_at"])
            : null,
        createdAt:
            DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"] ?? '') ?? DateTime.now(),
      );
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

  factory Paket.fromMap(Map<String, dynamic> json) => Paket(
        id: json["id"] ?? 0,
        namaPaket: json["nama_paket"] ?? '',
        jumlahJam: json["jumlah_jam"] ?? '',
        noRekening: json["no_rekening"] ?? '',
        deskripsi: json["deskripsi"] ?? '',
        harga: json["harga"] ?? '',
        createdAt:
            DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"] ?? '') ?? DateTime.now(),
      );
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

  factory Jadwal.fromMap(Map<String, dynamic> json) => Jadwal(
        id: json["id"] ?? 0,
        pesananId: json["pesanan_id"] ?? 0,
        instrukturId: json["instruktur_id"] ?? 0,
        tanggal: DateTime.tryParse(json["tanggal"] ?? '') ?? DateTime.now(),
        waktuMulai: json["waktu_mulai"] ?? '',
        waktuSelesai: json["waktu_selesai"] ?? '',
        status: json["status"] ?? '',
        createdAt:
            DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"] ?? '') ?? DateTime.now(),
      );
}
