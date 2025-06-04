
import 'dart:convert';

class DetailPesananKasirResponse {
  final bool success;
  final Data data;

  DetailPesananKasirResponse({
    required this.success,
    required this.data,
  });

  factory DetailPesananKasirResponse.fromJson(String str) =>
      DetailPesananKasirResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailPesananKasirResponse.fromMap(Map<String, dynamic> json) =>
      DetailPesananKasirResponse(
        success: json["success"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": data.toMap(),
      };
}

class Data {
  final int pesananId;
  final String namaUser;
  final String namaPaket;
  final String status;
  final int jumlahJamPaket;
  final int jamTerpakai;
  final int jamSisa;
  final String buktiPembayaran;
  final List<Jadwal> jadwal;

  Data({
    required this.pesananId,
    required this.namaUser,
    required this.namaPaket,
    required this.status,
    required this.jumlahJamPaket,
    required this.jamTerpakai,
    required this.jamSisa,
    required this.buktiPembayaran,
    required this.jadwal,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        pesananId: json["pesanan_id"],
        namaUser: json["nama_user"],
        namaPaket: json["nama_paket"],
        status: json["status"],
        jumlahJamPaket: json["jumlah_jam_paket"],
        jamTerpakai: json["jam_terpakai"],
        jamSisa: json["jam_sisa"],
        buktiPembayaran: json["bukti_pembayaran"],
        jadwal: List<Jadwal>.from(json["jadwal"].map((x) => Jadwal.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "pesanan_id": pesananId,
        "nama_user": namaUser,
        "nama_paket": namaPaket,
        "status": status,
        "jumlah_jam_paket": jumlahJamPaket,
        "jam_terpakai": jamTerpakai,
        "jam_sisa": jamSisa,
        "bukti_pembayaran": buktiPembayaran,
        "jadwal": List<dynamic>.from(jadwal.map((x) => x.toMap())),
      };
}

class Jadwal {
  final String instruktur;
  final String waktuMulai;
  final String waktuSelesai;
  final int jumlahJam;
  final String status;

  Jadwal({
    required this.instruktur,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.jumlahJam,
    required this.status,
  });

  factory Jadwal.fromJson(String str) => Jadwal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Jadwal.fromMap(Map<String, dynamic> json) => Jadwal(
        instruktur: json["instruktur"],
        waktuMulai: json["waktu_mulai"],
        waktuSelesai: json["waktu_selesai"],
        jumlahJam: json["jumlah_jam"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "instruktur": instruktur,
        "waktu_mulai": waktuMulai,
        "waktu_selesai": waktuSelesai,
        "jumlah_jam": jumlahJam,
        "status": status,
      };
}
