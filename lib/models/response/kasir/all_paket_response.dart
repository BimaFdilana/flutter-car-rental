import 'dart:convert';

class AllPaketResponse {
  final bool success;
  final List<Datum> data;

  AllPaketResponse({
    required this.success,
    required this.data,
  });

  factory AllPaketResponse.fromJson(String str) =>
      AllPaketResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllPaketResponse.fromMap(Map<String, dynamic> json) =>
      AllPaketResponse(
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





class ShowPaketResponse {
    final bool success;
    final Data data;

  ShowPaketResponse({
        required this.success,
        required this.data,
    });

  factory ShowPaketResponse.fromJson(String str) =>
      ShowPaketResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

  factory ShowPaketResponse.fromMap(Map<String, dynamic> json) =>
      ShowPaketResponse(
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
  final String noRekening;
    final String deskripsi;
    final String harga;
    final DateTime createdAt;
    final DateTime updatedAt;

    Data({
        required this.id,
        required this.namaPaket,
        required this.jumlahJam,
    required this.noRekening,
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

class CreatePaketResponse {
  final bool success;
  final String message;
  final Paket paket;

  CreatePaketResponse({
    required this.success,
    required this.message,
    required this.paket,
  });

  factory CreatePaketResponse.fromJson(String str) =>
      CreatePaketResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreatePaketResponse.fromMap(Map<String, dynamic> json) =>
      CreatePaketResponse(
        success: json["success"],
        message: json["message"],
        paket: Paket.fromMap(json["paket"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "paket": paket.toMap(),
      };
}

class Paket {
  final String namaPaket;
  final String jumlahJam;
  final String noRekening;
  final String deskripsi;
  final String harga;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Paket({
    required this.namaPaket,
    required this.jumlahJam,
    required this.noRekening,
    required this.deskripsi,
    required this.harga,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Paket.fromJson(String str) => Paket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Paket.fromMap(Map<String, dynamic> json) => Paket(
        namaPaket: json["nama_paket"],
        jumlahJam: json["jumlah_jam"],
        noRekening: json["no_rekening"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "nama_paket": namaPaket,
        "jumlah_jam": jumlahJam,
        "no_rekening": noRekening,
        "deskripsi": deskripsi,
        "harga": harga,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

class DeletedPaketResponse {
  final bool success;
  final String message;

  DeletedPaketResponse({
    required this.success,
    required this.message,
  });

  factory DeletedPaketResponse.fromJson(String str) =>
      DeletedPaketResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeletedPaketResponse.fromMap(Map<String, dynamic> json) =>
      DeletedPaketResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
      };
}
