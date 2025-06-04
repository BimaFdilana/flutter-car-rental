import 'dart:convert';

class AllPesananKasirResponse {
    final bool success;
    final List<Datum> data;

    AllPesananKasirResponse({
        required this.success,
        required this.data,
    });

    factory AllPesananKasirResponse.fromJson(String str) => AllPesananKasirResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllPesananKasirResponse.fromMap(Map<String, dynamic> json) => AllPesananKasirResponse(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Datum {
  final int pesananId;
  final String? namaUser;
  final String? namaPaket;
  final String? status;
  final int jumlahJamPaket;
  final String? mobil;
  final int jamTerpakai;
  final int jamSisa;
  final String? buktiPembayaran;

  Datum({
    required this.pesananId,
    this.namaUser,
    this.namaPaket,
    this.status,
    required this.jumlahJamPaket,
    this.mobil,
    required this.jamTerpakai,
    required this.jamSisa,
    this.buktiPembayaran,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        pesananId: json["pesanan_id"],
        namaUser: json["nama_user"],
        namaPaket: json["nama_paket"],
        status: json["status"],
        jumlahJamPaket: json["jumlah_jam_paket"],
        mobil: json["mobil"],
        jamTerpakai: json["jam_terpakai"],
        jamSisa: json["jam_sisa"],
        buktiPembayaran: json["bukti_pembayaran"],
      );

  Map<String, dynamic> toMap() => {
        "pesanan_id": pesananId,
        "nama_user": namaUser,
        "nama_paket": namaPaket,
        "status": status,
        "jumlah_jam_paket": jumlahJamPaket,
        "mobil": mobil,
        "jam_terpakai": jamTerpakai,
        "jam_sisa": jamSisa,
        "bukti_pembayaran": buktiPembayaran,
      };
}

