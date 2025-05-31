import 'dart:convert';

class AllPesananKasirResponse {
  final bool? success;
  final List<Datum>? data;

  AllPesananKasirResponse({
    this.success,
    this.data,
  });

  factory AllPesananKasirResponse.fromJson(String str) =>
      AllPesananKasirResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllPesananKasirResponse.fromMap(Map<String, dynamic> json) =>
      AllPesananKasirResponse(
        success: json["success"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromMap(x)))
            : null,
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toMap()))
            : null,
      };
}

class Datum {
  final int? pesananId;
  final String? namaUser;
  final String? namaPaket;
  final String? status;
  final int? jumlahJamPaket;
  final String? mobil;
  final int? jamTerpakai;
  final int? jamSisa;
  final String? buktiPembayaran;

  Datum({
    this.pesananId,
    this.namaUser,
    this.namaPaket,
    this.status,
    this.jumlahJamPaket,
    this.mobil,
    this.jamTerpakai,
    this.jamSisa,
    this.buktiPembayaran,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        pesananId:
            json["pesanan_id"] != null ? json["pesanan_id"] as int : null,
        namaUser:
            json["nama_user"] != null ? json["nama_user"] as String : null,
        namaPaket:
            json["nama_paket"] != null ? json["nama_paket"] as String : null,
        status: json["status"] != null ? json["status"] as String : null,
        jumlahJamPaket: json["jumlah_jam_paket"] != null
            ? json["jumlah_jam_paket"] as int
            : null,
        mobil: json["mobil"] != null ? json["mobil"] as String : null,
        jamTerpakai:
            json["jam_terpakai"] != null ? json["jam_terpakai"] as int : null,
        jamSisa: json["jam_sisa"] != null ? json["jam_sisa"] as int : null,
        buktiPembayaran: json["bukti_pembayaran"] != null
            ? json["bukti_pembayaran"] as String
            : null,
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
