import 'dart:convert';

class UserStatusResponseModel {
  final bool success;
  final Data data;

  UserStatusResponseModel({
    required this.success,
    required this.data,
  });

  factory UserStatusResponseModel.fromJson(String str) =>
      UserStatusResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserStatusResponseModel.fromMap(Map<String, dynamic> json) =>
      UserStatusResponseModel(
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
  final String paket;
  final String hargaPaket;
  final int jumlahJamPaket;
  final String mobil;
  final String buktiPembayaran;
  final String status;
  final int totalJamTerpakai;
  final int sisaJam;
  final List<Jadwal> jadwal;

  Data({
    required this.id,
    required this.paket,
    required this.hargaPaket,
    required this.jumlahJamPaket,
    required this.mobil,
    required this.buktiPembayaran,
    required this.status,
    required this.totalJamTerpakai,
    required this.sisaJam,
    required this.jadwal,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        paket: json["paket"],
        hargaPaket: json["harga_paket"],
        jumlahJamPaket: json["jumlah_jam_paket"],
        mobil: json["mobil"],
        buktiPembayaran: json["bukti_pembayaran"],
        status: json["status"],
        totalJamTerpakai: json["total_jam_terpakai"],
        sisaJam: json["sisa_jam"],
        jadwal: List<Jadwal>.from(json["jadwal"].map((x) => Jadwal.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "paket": paket,
        "harga_paket": hargaPaket,
        "jumlah_jam_paket": jumlahJamPaket,
        "mobil": mobil,
        "bukti_pembayaran": buktiPembayaran,
        "status": status,
        "total_jam_terpakai": totalJamTerpakai,
        "sisa_jam": sisaJam,
        "jadwal": List<dynamic>.from(jadwal.map((x) => x.toMap())),
      };
}

class Jadwal {
  final int id;
  final DateTime tanggal;
  final String waktuMulai;
  final String waktuSelesai;
  final String status;
  final double durasiJam;

  Jadwal({
    required this.id,
    required this.tanggal,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.status,
    required this.durasiJam,
  });

  factory Jadwal.fromJson(String str) => Jadwal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Jadwal.fromMap(Map<String, dynamic> json) => Jadwal(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        waktuMulai: json["waktu_mulai"],
        waktuSelesai: json["waktu_selesai"],
        status: json["status"],
        durasiJam: json["durasi_jam"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "waktu_mulai": waktuMulai,
        "waktu_selesai": waktuSelesai,
        "status": status,
        "durasi_jam": durasiJam,
      };
}
