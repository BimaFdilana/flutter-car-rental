class UserStatusResponseModel {
  final bool success;
  final List<Data> data;

  UserStatusResponseModel({
    required this.success,
    required this.data,
  });

  factory UserStatusResponseModel.fromMap(Map<String, dynamic> map) {
    return UserStatusResponseModel(
      success: map['success'] as bool,
      data: List<Data>.from(map['data'].map((x) => Data.fromMap(x))),
    );
  }
}

class Data {
  final int id;
  final String name;
  final String username;
  final String noHp;
  final String? email;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final List<Pesanan> pesanan;

  Data({
    required this.id,
    required this.name,
    required this.username,
    required this.noHp,
    this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.pesanan,
  });

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      noHp: map['no_hp'] as String,
      email: map['email'],
      emailVerifiedAt: map['email_verified_at'],
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      pesanan:
          List<Pesanan>.from(map['pesanan'].map((x) => Pesanan.fromMap(x))),
    );
  }
}

class Pesanan {
  final int id;
  final int userId;
  final int paketId;
  final String mobil;
  final String buktiPembayaran;
  final String status;
  final String createdAt;
  final String updatedAt;
  final List<Jadwal> jadwal;

  Pesanan({
    required this.id,
    required this.userId,
    required this.paketId,
    required this.mobil,
    required this.buktiPembayaran,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.jadwal,
  });

  factory Pesanan.fromMap(Map<String, dynamic> map) {
    return Pesanan(
      id: map['id'] as int,
      userId: map['user_id'] as int,
      paketId: map['paket_id'] as int,
      mobil: map['mobil']?.toString() ?? '',
      buktiPembayaran: map['bukti_pembayaran']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      jadwal: List<Jadwal>.from(map['jadwal'].map((x) => Jadwal.fromMap(x))),
    );
  }
}

class Jadwal {
  final int id;
  final int pesananId;
  final int? instrukturId;
  final String tanggal;
  final String waktuMulai;
  final String waktuSelesai;
  final String status;
  final String createdAt;
  final String updatedAt;

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

  factory Jadwal.fromMap(Map<String, dynamic> map) {
    return Jadwal(
      id: map['id'] as int,
      pesananId: map['pesanan_id'] as int,
      instrukturId:
          map['instruktur_id'] != null ? map['instruktur_id'] as int : null,
      tanggal: map['tanggal'] as String,
      waktuMulai: map['waktu_mulai'] as String,
      waktuSelesai: map['waktu_selesai'] as String,
      status: map['status'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}
