import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kursus_mengemudi_nasional/logic/all_jadwal/all_jadwal_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/update_status_kasir/update_status_kasir_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/change_jadwal_status_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_jadwal_response.dart';

class JadwalListPage extends StatefulWidget {
  const JadwalListPage({super.key});

  @override
  JadwalListPageState createState() => JadwalListPageState();
}

String formatDateTime(String? rawDate) {
  if (rawDate == null) return '-';
  try {
    final dateTime =
        DateTime.parse(rawDate).toLocal(); // dari UTC ke waktu lokal
    return "${DateFormat("dd MMMM yyyy, HH:mm", "id_ID").format(dateTime)} WIB";
  } catch (e) {
    return '-';
  }
}

class JadwalListPageState extends State<JadwalListPage> {
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'finished':
        return Colors.green;
      case 'processing':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.access_time;
      case 'finished':
        return Icons.check_circle;
      case 'processing':
        return Icons.sync;
      default:
        return Icons.help_outline;
    }
  }

  void _updateStatus(int index, JadwalKasirItem jadwal, String newStatus) {
    final request = ChangeJadwalKasirRequest(
      id: jadwal.id,
      status: newStatus,
    );

    context
        .read<UpdateStatusKasirBloc>()
        .add(UpdateStatusKasirEvent.started(request));
  }

  @override
  void initState() {
    context.read<AllJadwalBloc>().add(AllJadwalEvent.started());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateStatusKasirBloc, UpdateStatusKasirState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {
            // Opsional: Tampilkan loading dialog atau snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Memperbarui status...')),
            );
          },
          success: (response) {
            // Misal refresh daftar jadwal setelah update sukses
            context.read<AllJadwalBloc>().add(AllJadwalEvent.started());

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Status berhasil diperbarui'),
                backgroundColor: Colors.green,
              ),
            );
          },
          error: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal memperbarui status: $error')),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1976D2),
          elevation: 0,
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
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.schedule,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jadwal Instruktur',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Kelola jadwal pelatihan Anda',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // List Container
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              Text(
                                'Daftar Jadwal',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E3A8A),
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Color(0xFF3B82F6).withValues(),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:
                                    BlocBuilder<AllJadwalBloc, AllJadwalState>(
                                  builder: (context, state) {
                                    return state.maybeWhen(
                                        orElse: () => Text('0'),
                                        success: (jadwalList) => Text(
                                              jadwalList.data.length.toString(),
                                              style: TextStyle(
                                                color: Color(0xFF1E3A8A),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // List
                        Expanded(
                          child: BlocBuilder<AllJadwalBloc, AllJadwalState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                  orElse: () => SizedBox(),
                                  success: (jadwalList) {
                                    final data = jadwalList.data;
                                    return ListView.builder(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 24),
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        final jadwal = data[index];
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFF3B82F6)
                                                    .withOpacity(0.1),
                                                blurRadius: 20,
                                                offset: Offset(0, 8),
                                              ),
                                            ],
                                            border: Border.all(
                                              color: Color(0xFF3B82F6)
                                                  .withOpacity(0.1),
                                              width: 1,
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      JadwalDetailPage(
                                                          jadwal: jadwal),
                                                ),
                                              );
                                            },
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _getStatusColor(
                                                                  jadwal
                                                                      .status!)
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        child: Icon(
                                                          _getStatusIcon(
                                                              jadwal.status!),
                                                          color:
                                                              _getStatusColor(
                                                                  jadwal
                                                                      .status!),
                                                          size: 20,
                                                        ),
                                                      ),
                                                      SizedBox(width: 12),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'ID: ${jadwal.id}',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFF1E3A8A),
                                                              ),
                                                            ),
                                                            Text(
                                                              jadwal.instruktur
                                                                      ?.name ??
                                                                  '',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey[600],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 12,
                                                                vertical: 6),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              _getStatusColor(
                                                                  jadwal
                                                                      .status!),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Text(
                                                          jadwal.status
                                                                  ?.toUpperCase() ??
                                                              '',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: _buildInfoCard(
                                                          Icons.directions_car,
                                                          'Mobil',
                                                          jadwal.pesanan
                                                                  ?.mobil ??
                                                              '',
                                                          Color(0xFF3B82F6),
                                                        ),
                                                      ),
                                                      SizedBox(width: 12),
                                                      Expanded(
                                                        child: _buildInfoCard(
                                                          Icons.calendar_today,
                                                          'Tanggal',
                                                          formatDateTime(jadwal
                                                              .tanggal
                                                              .toString()),
                                                          Color(0xFF10B981),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 12),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: _buildInfoCard(
                                                          Icons.access_time,
                                                          'Waktu',
                                                          '${jadwal.waktuMulai?.substring(0, 5) ?? ''} - ${jadwal.waktuSelesai?.substring(0, 5) ?? ''}',
                                                          Color(0xFFF59E0B),
                                                        ),
                                                      ),
                                                      SizedBox(width: 12),
                                                      if (jadwal.status !=
                                                          'finished')
                                                        Expanded(
                                                          child: ElevatedButton
                                                              .icon(
                                                            onPressed: () =>
                                                                _updateStatus(
                                                                    index,
                                                                    jadwal,
                                                                    'finished'),
                                                            icon: Icon(
                                                                Icons.check,
                                                                size: 16),
                                                            label:
                                                                Text('Selesai'),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              foregroundColor:
                                                                  Colors.white,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      else
                                                        Expanded(
                                                            child: SizedBox()),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      IconData icon, String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
        ],
      ),
    );
  }
}

class JadwalDetailPage extends StatelessWidget {
  final JadwalKasirItem jadwal;

  const JadwalDetailPage({super.key, required this.jadwal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Jadwal'),
      ),
      body: SafeArea(
        child: Container(
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
              // Detail Container
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF1E3A8A)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Status: ${jadwal.status?.toUpperCase() ?? ''}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Jadwal ID: ${jadwal.id}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),

                      // Jadwal Info
                      _buildSectionTitle('Informasi Jadwal'),
                      _buildDetailCard([
                        _buildDetailRow('ID Jadwal', jadwal.id.toString()),
                        _buildDetailRow(
                            'ID Pesanan', jadwal.pesananId.toString()),
                        _buildDetailRow(
                            'ID Instruktur', jadwal.instrukturId.toString()),
                        _buildDetailRow('Tanggal', jadwal.tanggal.toString()),
                        _buildDetailRow(
                            'Waktu Mulai', jadwal.waktuMulai.toString()),
                        _buildDetailRow(
                            'Waktu Selesai', jadwal.waktuSelesai.toString()),
                        _buildDetailRow('Status', jadwal.status.toString()),
                        _buildDetailRow('Dibuat',
                            formatDateTime(jadwal.createdAt.toString())),
                        _buildDetailRow('Diperbarui',
                            formatDateTime(jadwal.updatedAt.toString())),
                      ]),

                      SizedBox(height: 24),

                      // Pesanan Info
                      _buildSectionTitle('Informasi Pesanan'),
                      _buildDetailCard([
                        _buildDetailRow(
                            'ID Pesanan', jadwal.pesanan!.id.toString()),
                        _buildDetailRow(
                            'ID User', jadwal.pesanan!.userId.toString()),
                        _buildDetailRow(
                            'ID Paket', jadwal.pesanan!.paketId.toString()),
                        _buildDetailRow(
                            'Mobil', jadwal.pesanan!.mobil.toString()),
                        _buildDetailRow('Bukti Pembayaran',
                            jadwal.pesanan!.buktiPembayaran ?? 'Belum ada'),
                        _buildDetailRow('Status Pesanan',
                            jadwal.pesanan!.status.toString()),
                        _buildDetailRow(
                            'Dibuat',
                            formatDateTime(
                                jadwal.pesanan!.createdAt.toString())),
                        _buildDetailRow(
                            'Diperbarui',
                            formatDateTime(
                                jadwal.pesanan!.updatedAt.toString())),
                      ]),

                      SizedBox(height: 24),

                      // Instruktur Info
                      _buildSectionTitle('Informasi Instruktur'),
                      _buildDetailCard([
                        _buildDetailRow(
                            'ID Instruktur', jadwal.instruktur!.id.toString()),
                        _buildDetailRow(
                            'Nama', jadwal.instruktur!.name.toString()),
                        _buildDetailRow(
                            'Username', jadwal.instruktur!.username.toString()),
                        _buildDetailRow(
                            'No. HP', jadwal.instruktur!.noHp.toString()),
                        _buildDetailRow(
                            'Email', jadwal.instruktur!.email.toString()),
                        _buildDetailRow('Email Verified',
                            jadwal.instruktur!.emailVerifiedAt.toString()),
                        _buildDetailRow(
                            'Dibuat',
                            formatDateTime(
                                jadwal.instruktur!.createdAt.toString())),
                        _buildDetailRow(
                            'Diperbarui',
                            formatDateTime(
                                jadwal.instruktur!.updatedAt.toString())),
                      ]),

                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E3A8A),
        ),
      ),
    );
  }

  Widget _buildDetailCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3B82F6).withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Color(0xFF3B82F6).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            ': ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF1E3A8A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
