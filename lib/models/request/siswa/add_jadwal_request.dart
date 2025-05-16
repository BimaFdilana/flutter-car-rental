class AddJadwalRequestModel {
  final int pesananId;
  final List<JadwalItem> jadwal;

  AddJadwalRequestModel({
    required this.pesananId,
    required this.jadwal,
  });

  Map<String, dynamic> toJson() => {
        'pesanan_id': pesananId,
        'jadwal': jadwal.map((e) => e.toJson()).toList(),
      };
}

class JadwalItem {
  final String tanggal;
  final String waktuMulai;
  final String waktuSelesai;

  JadwalItem({
    required this.tanggal,
    required this.waktuMulai,
    required this.waktuSelesai,
  });

  Map<String, dynamic> toJson() => {
        'tanggal': tanggal,
        'waktu_mulai': waktuMulai,
        'waktu_selesai': waktuSelesai,
      };
}

