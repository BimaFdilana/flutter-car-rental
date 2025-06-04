import 'dart:convert';

class AllKasirResponse {
  final bool success;
  final List<Datum> data;

  AllKasirResponse({
    required this.success,
    required this.data,
  });

  factory AllKasirResponse.fromJson(String str) =>
      AllKasirResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllKasirResponse.fromMap(Map<String, dynamic> json) =>
      AllKasirResponse(
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
  final String deskripsi;
  final String harga;
  final DateTime createdAt;
  final DateTime updatedAt;

  Datum({
    required this.id,
    required this.namaPaket,
    required this.jumlahJam,
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
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nama_paket": namaPaket,
        "jumlah_jam": jumlahJam,
        "deskripsi": deskripsi,
        "harga": harga,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}


class ShowKasirResponse {
    final bool success;
    final Data data;

    ShowKasirResponse({
        required this.success,
        required this.data,
    });

    factory ShowKasirResponse.fromJson(String str) => ShowKasirResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ShowKasirResponse.fromMap(Map<String, dynamic> json) => ShowKasirResponse(
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
    final String namaPaket;
    final String jumlahJam;
    final String deskripsi;
    final String harga;
    final DateTime createdAt;
    final DateTime updatedAt;

    Data({
        required this.id,
        required this.namaPaket,
        required this.jumlahJam,
        required this.deskripsi,
        required this.harga,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        namaPaket: json["nama_paket"],
        jumlahJam: json["jumlah_jam"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nama_paket": namaPaket,
        "jumlah_jam": jumlahJam,
        "deskripsi": deskripsi,
        "harga": harga,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
