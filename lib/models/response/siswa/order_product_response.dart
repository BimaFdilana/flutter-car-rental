import 'dart:convert';

import 'package:kursus_mengemudi_nasional/models/response/siswa/jadwal_convert.dart';

class OrderProdukResponseModel {
  final bool success;
  final Pesanan pesanan;

  OrderProdukResponseModel({
    required this.success,
    required this.pesanan,
  });

  factory OrderProdukResponseModel.fromJson(String str) =>
      OrderProdukResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderProdukResponseModel.fromMap(Map<String, dynamic> json) =>
      OrderProdukResponseModel(
        success: json["success"],
        pesanan: Pesanan.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": pesanan.toMap(),
      };
}

class Pesanan {
  final int id;
  final String paket;
  final int jumlahJamPaket;
  final String? mobil;
  final String? buktiPembayaran;
  final String status;
  final double totalJamTerpakai; // ubah ke double
  final double sisaJam; // ubah ke double
  final List<Jadwal> jadwal;

  Pesanan({
    required this.id,
    required this.paket,
    required this.jumlahJamPaket,
    this.mobil,
    this.buktiPembayaran,
    required this.status,
    required this.totalJamTerpakai,
    required this.sisaJam,
    required this.jadwal,
  });

  factory Pesanan.fromMap(Map<String, dynamic> json) => Pesanan(
        id: json["id"],
        paket: json["paket"],
        jumlahJamPaket: json["jumlah_jam_paket"],
        mobil: json["mobil"],
        buktiPembayaran: json["bukti_pembayaran"],
        status: json["status"],
        totalJamTerpakai: (json["total_jam_terpakai"] as num).toDouble(),
        sisaJam: (json["sisa_jam"] as num).toDouble(),
        jadwal: (json["jadwal"] as List<dynamic>?)
                ?.map((item) => Jadwal.fromMap(item))
                .toList() ??
            [],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "paket": paket,
        "jumlah_jam_paket": jumlahJamPaket,
        "mobil": mobil,
        "bukti_pembayaran": buktiPembayaran,
        "status": status,
        "total_jam_terpakai": totalJamTerpakai,
        "sisa_jam": sisaJam,
        "jadwal": jadwal.map((x) => x.toMap()).toList(),
      };
}
