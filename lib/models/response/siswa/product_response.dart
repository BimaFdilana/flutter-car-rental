import 'dart:convert';

class AllProductResponseModel {
  final bool success;
  final List<Datum> data;

  AllProductResponseModel({
    required this.success,
    required this.data,
  });

  factory AllProductResponseModel.fromJson(String str) =>
      AllProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllProductResponseModel.fromMap(Map<String, dynamic> json) =>
      AllProductResponseModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  final int id;
  final String namaPaket;
  final String jumlahJam;
  final String noRekening;
  final String deskripsi;
  final String harga;
  final DateTime createdAt;
  final DateTime updatedAt;

  Datum({
    required this.id,
    required this.namaPaket,
    required this.jumlahJam,
    required this.noRekening,
    required this.deskripsi,
    required this.harga,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
