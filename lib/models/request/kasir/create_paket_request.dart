import 'dart:convert';

class CreatePaketRequest {
  final String namaPaket;
  final String jumlahJam;
  final String noRekening;
  final String deskripsi;
  final String harga;

  CreatePaketRequest({
    required this.namaPaket,
    required this.jumlahJam,
    required this.noRekening,
    required this.deskripsi,
    required this.harga,
  });

  factory CreatePaketRequest.fromJson(String str) =>
      CreatePaketRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreatePaketRequest.fromMap(Map<String, dynamic> json) =>
      CreatePaketRequest(
        namaPaket: json["nama_paket"],
        jumlahJam: json["jumlah_jam"],
        noRekening: json["no_rekening"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
      );

  Map<String, dynamic> toMap() => {
        "nama_paket": namaPaket,
        "jumlah_jam": jumlahJam,
        "no_rekening": noRekening,
        "deskripsi": deskripsi,
        "harga": harga,
      };
}
