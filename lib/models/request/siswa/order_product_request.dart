import 'dart:convert';

class OrderProdukRequestModel {
  final int idPaket;
  final String mobil;

  OrderProdukRequestModel({
    required this.idPaket,
    required this.mobil,
  });

  factory OrderProdukRequestModel.fromJson(String str) =>
      OrderProdukRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderProdukRequestModel.fromMap(Map<String, dynamic> json) =>
      OrderProdukRequestModel(
        idPaket: json["id_paket"],
        mobil: json["mobil"],
      );

  Map<String, dynamic> toMap() => {
        "id_paket": idPaket,
        "mobil": mobil,
      };
}
