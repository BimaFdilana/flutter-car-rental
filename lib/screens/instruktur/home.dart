import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({Key? key}) : super(key: key);

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  // Contoh data sesuai dengan JSON yang diberikan
  final Map<String, dynamic> responseData = {
    "success": true,
    "data": [
      {
        "id": 3,
        "name": "Siswa",
        "username": "siswa",
        "no_hp": "081234567892",
        "email": "siswa@example.com",
        "email_verified_at": "2025-05-11T20:45:15.000000Z",
        "created_at": "2025-05-11T20:45:15.000000Z",
        "updated_at": "2025-05-11T20:45:15.000000Z",
        "pesanan": [
          {
            "id": 64,
            "user_id": 3,
            "paket_id": 1,
            "mobil": "Toyota Agya Manual",
            "bukti_pembayaran": "buktipembayaran/Arw0JyWUrpmdRBPe8j2M.jpg",
            "status": "success",
            "created_at": "2025-05-16T19:50:12.000000Z",
            "updated_at": "2025-05-16T20:39:47.000000Z",
            "jadwal": [
              {
                "id": 55,
                "pesanan_id": 64,
                "instruktur_id": null,
                "tanggal": "2025-05-21",
                "waktu_mulai": "04:00:00",
                "waktu_selesai": "05:00:00",
                "status": "pending",
                "created_at": "2025-05-16T20:03:52.000000Z",
                "updated_at": "2025-05-16T20:03:52.000000Z"
              },
              {
                "id": 56,
                "pesanan_id": 64,
                "instruktur_id": null,
                "tanggal": "2025-05-31",
                "waktu_mulai": "03:26:00",
                "waktu_selesai": "05:26:00",
                "status": "pending",
                "created_at": "2025-05-16T20:26:06.000000Z",
                "updated_at": "2025-05-16T20:26:06.000000Z"
              },
              {
                "id": 57,
                "pesanan_id": 64,
                "instruktur_id": null,
                "tanggal": "2025-06-01",
                "waktu_mulai": "03:29:00",
                "waktu_selesai": "06:29:00",
                "status": "pending",
                "created_at": "2025-05-16T20:29:17.000000Z",
                "updated_at": "2025-05-16T20:29:17.000000Z"
              },
              {
                "id": 58,
                "pesanan_id": 64,
                "instruktur_id": null,
                "tanggal": "2025-06-04",
                "waktu_mulai": "03:30:00",
                "waktu_selesai": "05:30:00",
                "status": "pending",
                "created_at": "2025-05-16T20:30:22.000000Z",
                "updated_at": "2025-05-16T20:30:22.000000Z"
              },
              {
                "id": 59,
                "pesanan_id": 64,
                "instruktur_id": null,
                "tanggal": "2025-05-15",
                "waktu_mulai": "09:00:00",
                "waktu_selesai": "11:00:00",
                "status": "pending",
                "created_at": "2025-05-16T20:30:54.000000Z",
                "updated_at": "2025-05-16T20:30:54.000000Z"
              },
              {
                "id": 60,
                "pesanan_id": 64,
                "instruktur_id": null,
                "tanggal": "2025-05-16",
                "waktu_mulai": "13:00:00",
                "waktu_selesai": "15:00:00",
                "status": "pending",
                "created_at": "2025-05-16T20:30:54.000000Z",
                "updated_at": "2025-05-16T20:30:54.000000Z"
              },
              {
                "id": 61,
                "pesanan_id": 64,
                "instruktur_id": null,
                "tanggal": "2025-06-05",
                "waktu_mulai": "03:33:00",
                "waktu_selesai": "05:33:00",
                "status": "pending",
                "created_at": "2025-05-16T20:33:47.000000Z",
                "updated_at": "2025-05-16T20:33:47.000000Z"
              }
            ]
          }
        ]
      },
      {
        "id": 12,
        "name": "pina",
        "username": "pina",
        "no_hp": "089620044389",
        "email": null,
        "email_verified_at": null,
        "created_at": "2025-05-16T20:43:37.000000Z",
        "updated_at": "2025-05-16T20:43:37.000000Z",
        "pesanan": [
          {
            "id": 65,
            "user_id": 12,
            "paket_id": 2,
            "mobil": "Toyota Agya Manual",
            "bukti_pembayaran": "buktipembayaran/Vq5IcA5876NLOzu4yp8X.jpg",
            "status": "success",
            "created_at": "2025-05-16T20:43:49.000000Z",
            "updated_at": "2025-05-16T20:44:36.000000Z",
            "jadwal": [
              {
                "id": 62,
                "pesanan_id": 65,
                "instruktur_id": null,
                "tanggal": "2025-05-22",
                "waktu_mulai": "03:44:00",
                "waktu_selesai": "05:44:00",
                "status": "pending",
                "created_at": "2025-05-16T20:44:12.000000Z",
                "updated_at": "2025-05-16T20:44:12.000000Z"
              }
            ]
          }
        ]
      }
    ]
  };

  void _updateStatus(int jadwalId, String newStatus) {
    // Implementasi untuk update status
    // Pada kasus nyata, ini akan memanggil API untuk mengubah status

    setState(() {
      for (var user in responseData["data"]) {
        for (var pesanan in user["pesanan"]) {
          for (var i = 0; i < pesanan["jadwal"].length; i++) {
            if (pesanan["jadwal"][i]["id"] == jadwalId) {
              pesanan["jadwal"][i]["status"] = newStatus;
              break;
            }
          }
        }
      }
    });

    final statusEmojis = {
      'pending': '⏳',
      'completed': '✅',
      'cancelled': '❌',
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Text(statusEmojis[newStatus] ?? ''),
            const SizedBox(width: 8),
            Text('Status jadwal berhasil diubah menjadi $newStatus'),
          ],
        ),
        backgroundColor: _getStatusColor(newStatus),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _formatDateTime(String date, String time) {
    final DateFormat dateFormatter = DateFormat('dd MMMM yyyy');
    final DateFormat timeFormatter = DateFormat('HH:mm');

    final DateTime dateObj = DateTime.parse(date);
    final DateTime timeObj = DateFormat('HH:mm:ss').parse(time);

    final String formattedDate = dateFormatter.format(dateObj);
    final String formattedTime = timeFormatter.format(timeObj);

    return '$formattedDate, $formattedTime';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return const Color(0xFFFF9800);
      case "completed":
        return const Color(0xFF4CAF50);
      case "cancelled":
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "pending":
        return Icons.timelapse;
      case "completed":
        return Icons.check_circle;
      case "cancelled":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> users = responseData["data"];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Jadwal Kursus"),
      ),
      body: users.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Tidak ada jadwal tersedia",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: users.length,
              itemBuilder: (context, userIndex) {
                final user = users[userIndex];
                final List<dynamic> pesananList = user["pesanan"];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      expandedAlignment: Alignment.topLeft,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      childrenPadding: const EdgeInsets.only(bottom: 16),
                      tilePadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        child: Text(
                          user['name'][0].toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        user['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.phone_android,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              user['no_hp'],
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      children: pesananList.map<Widget>(
                        (pesanan) {
                          final List<dynamic> jadwalList = pesanan["jadwal"];
                          final statusIcon = pesanan['status'] == 'success'
                              ? const Icon(Icons.check_circle,
                                  color: Color(0xFF4CAF50), size: 14)
                              : const Icon(Icons.error,
                                  color: Colors.red, size: 14);

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Pesanan #${pesanan['id']}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              statusIcon,
                                              const SizedBox(width: 4),
                                              Text(
                                                pesanan['status'],
                                                style: TextStyle(
                                                  color: pesanan['status'] ==
                                                          'success'
                                                      ? const Color(0xFF4CAF50)
                                                      : Colors.red,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.directions_car,
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            pesanan['mobil'],
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.event_note,
                                      size: 16,
                                      color: Color(0xFF536DFE),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Jadwal Kursus (${jadwalList.length})",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color(0xFF536DFE),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                ...jadwalList.map((jadwal) {
                                  final String statusText = jadwal["status"];
                                  final Color statusColor =
                                      _getStatusColor(statusText);
                                  final IconData statusIcon =
                                      _getStatusIcon(statusText);
                                  final bool isPast =
                                      DateTime.parse(jadwal['tanggal'])
                                          .isBefore(DateTime.now());

                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey.shade200),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade100,
                                          blurRadius: 3,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                          decoration: BoxDecoration(
                                            color: isPast
                                                ? Colors.grey.shade100
                                                : Colors.white,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.calendar_today,
                                                      size: 16,
                                                      color: Colors.black54,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Flexible(
                                                      child: Text(
                                                        _formatDateTime(
                                                            jadwal['tanggal'],
                                                            jadwal[
                                                                'waktu_mulai']),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: statusColor
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      statusIcon,
                                                      size: 14,
                                                      color: statusColor,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      statusText,
                                                      style: TextStyle(
                                                        color: statusColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.access_time,
                                                          size: 16,
                                                          color: Colors.black54,
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Text(
                                                          "${jadwal['waktu_mulai'].substring(0, 5)} - ${jadwal['waktu_selesai'].substring(0, 5)}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "ID: ${jadwal['id']}",
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                              const Text(
                                                "Update Status:",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  _buildStatusButton(
                                                    jadwal['id'],
                                                    "pending",
                                                    const Color(0xFFFF9800),
                                                    jadwal["status"] ==
                                                        "pending",
                                                    Icons.timelapse,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  _buildStatusButton(
                                                    jadwal['id'],
                                                    "completed",
                                                    const Color(0xFF4CAF50),
                                                    jadwal["status"] ==
                                                        "completed",
                                                    Icons.check_circle,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  _buildStatusButton(
                                                    jadwal['id'],
                                                    "cancelled",
                                                    const Color(0xFFF44336),
                                                    jadwal["status"] ==
                                                        "cancelled",
                                                    Icons.cancel,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildStatusButton(
      int jadwalId, String status, Color color, bool isActive, IconData icon) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: isActive ? null : () => _updateStatus(jadwalId, status),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isActive ? Colors.grey.shade300 : color.withOpacity(0.1),
          foregroundColor: isActive ? Colors.grey.shade700 : color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isActive ? Colors.grey.shade400 : color.withOpacity(0.5),
              width: 1,
            ),
          ),
        ),
        icon: Icon(icon, size: 16),
        label: Text(status),
      ),
    );
  }
}
