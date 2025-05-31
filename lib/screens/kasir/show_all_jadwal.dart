import 'package:flutter/material.dart';

class ShowAllJadwal extends StatefulWidget {
  const ShowAllJadwal({super.key});

  @override
  State<ShowAllJadwal> createState() => _ShowAllJadwalState();
}

class _ShowAllJadwalState extends State<ShowAllJadwal> {
  List<Map<String, dynamic>> jadwalList = [
    {
      'id': 'JDW001',
      'kursus': 'Flutter Mobile Development',
      'instruktur': 'Ahmad Santoso',
      'hari': 'Senin, Rabu, Jumat',
      'waktu': '19:00 - 21:00',
      'durasi': '3 Bulan',
      'peserta': 15,
      'maksimal': 20,
      'status': 'Aktif',
    },
    {
      'id': 'JDW002',
      'kursus': 'React Web Development',
      'instruktur': 'Sari Dewi',
      'hari': 'Selasa, Kamis',
      'waktu': '20:00 - 22:00',
      'durasi': '2 Bulan',
      'peserta': 12,
      'maksimal': 15,
      'status': 'Aktif',
    },
    {
      'id': 'JDW003',
      'kursus': 'Laravel Backend',
      'instruktur': 'Budi Prasetyo',
      'hari': 'Sabtu, Minggu',
      'waktu': '09:00 - 12:00',
      'durasi': '4 Bulan',
      'peserta': 8,
      'maksimal': 12,
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Kursus'),
        backgroundColor: Color(0xFF1976D2),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddJadwalDialog(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1976D2),
              Color(0xFFF5F7FA),
            ],
            stops: [0.0, 0.3],
          ),
        ),
        child: Column(
          children: [
            // Header Stats
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                      'Total Kursus', '${jadwalList.length}', Icons.school),
                  _buildStatItem('Aktif', '2', Icons.play_circle),
                  _buildStatItem('Pending', '1', Icons.pause_circle),
                ],
              ),
            ),

            // Jadwal List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: jadwalList.length,
                itemBuilder: (context, index) {
                  final jadwal = jadwalList[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                jadwal['id'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1976D2),
                                ),
                              ),
                              _buildStatusChip(jadwal['status']),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            jadwal['kursus'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          _buildInfoRow(
                              Icons.person, 'Instruktur', jadwal['instruktur']),
                          _buildInfoRow(
                              Icons.calendar_today, 'Hari', jadwal['hari']),
                          _buildInfoRow(
                              Icons.access_time, 'Waktu', jadwal['waktu']),
                          _buildInfoRow(
                              Icons.schedule, 'Durasi', jadwal['durasi']),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFF1976D2).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Peserta: ${jadwal['peserta']}/${jadwal['maksimal']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1976D2),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor:
                                        jadwal['peserta'] / jadwal['maksimal'],
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1976D2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Color(0xFF1976D2), size: 24),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor = status == 'Aktif' ? Colors.green : Colors.orange;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: chipColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showAddJadwalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Tambah Jadwal Baru'),
          content: Text('Fitur tambah jadwal akan segera tersedia'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: TextStyle(color: Color(0xFF1976D2))),
            ),
          ],
        );
      },
    );
  }
}
