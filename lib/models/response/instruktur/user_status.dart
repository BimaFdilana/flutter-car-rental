class UserStatusResponseModel {
  final bool success;
  final List<Data> data;

  UserStatusResponseModel({
    required this.success,
    required this.data,
  });

  factory UserStatusResponseModel.fromMap(Map<String, dynamic> map) {
    return UserStatusResponseModel(
      success: map['success'] == true,
      data: map['data'] is List
          ? List<Data>.from((map['data'] as List).map((x) => Data.fromMap(x)))
          : [],
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
      id: int.tryParse(map['id'].toString()) ?? 0,
      name: map['name']?.toString() ?? '',
      username: map['username']?.toString() ?? '',
      noHp: map['no_hp']?.toString() ?? '',
      email: map['email']?.toString(),
      emailVerifiedAt: map['email_verified_at']?.toString(),
      createdAt: map['created_at']?.toString() ?? '',
      updatedAt: map['updated_at']?.toString() ?? '',
      pesanan: map['pesanan'] is List
          ? List<Pesanan>.from(
              (map['pesanan'] as List).map((x) => Pesanan.fromMap(x)))
          : [],
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
      id: int.tryParse(map['id'].toString()) ?? 0,
      userId: int.tryParse(map['user_id'].toString()) ?? 0,
      paketId: int.tryParse(map['paket_id'].toString()) ?? 0,
      mobil: map['mobil']?.toString() ?? '',
      buktiPembayaran: map['bukti_pembayaran']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      createdAt: map['created_at']?.toString() ?? '',
      updatedAt: map['updated_at']?.toString() ?? '',
      jadwal: map['jadwal'] is List
          ? List<Jadwal>.from(
              (map['jadwal'] as List).map((x) => Jadwal.fromMap(x)))
          : [],
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
      id: int.tryParse(map['id'].toString()) ?? 0,
      pesananId: int.tryParse(map['pesanan_id'].toString()) ?? 0,
      instrukturId: map['instruktur_id'] != null
          ? int.tryParse(map['instruktur_id'].toString())
          : null,
      tanggal: map['tanggal'] as String,
      waktuMulai: map['waktu_mulai'] as String,
      waktuSelesai: map['waktu_selesai'] as String,
      status: map['status'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}
