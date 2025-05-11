class Jadwal {
  final int id;
  final String tanggal;
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

  factory Jadwal.fromMap(Map<String, dynamic> json) => Jadwal(
        id: json["id"],
        tanggal: json["tanggal"],
        waktuMulai: json["waktu_mulai"],
        waktuSelesai: json["waktu_selesai"],
        status: json["status"],
        durasiJam: (json["durasi_jam"] as num).toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tanggal": tanggal,
        "waktu_mulai": waktuMulai,
        "waktu_selesai": waktuSelesai,
        "status": status,
        "durasi_jam": durasiJam,
      };
}
