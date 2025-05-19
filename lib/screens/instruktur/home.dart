import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kursus_mengemudi_nasional/logic/logout/logout_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/update_status_instruktur/update_status_instruktut_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/user_status/user_status_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/request/instruktur/update_status_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/instruktur/user_status.dart';
import 'package:kursus_mengemudi_nasional/screens/siswa/login_page.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
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
  void initState() {
    super.initState();
    context.read<UserStatusBloc>().add(UserStatusEvent.userStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Jadwal Kursus"),
        actions: [
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                success: () {
                  AuthlocalDatasource().removeLoginData();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                },
              );
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                },
                icon: const Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<UserStatusBloc, UserStatusState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Center(child: CircularProgressIndicator()),
            success: (data) {
              final allPesanan =
                  data.data.expand((user) => user.pesanan).toList();

              final name = data.data.map((user) => user.username).toList();

              if (allPesanan.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ganti dengan logo kamu
                      Icon(Icons.edit_document, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text(
                        'Tidak ada jadwal',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: allPesanan.length,
                itemBuilder: (context, index) {
                  final pesanan = allPesanan[index];
                  return UserStatusCard(
                    name: name[index],
                    status: pesanan.status,
                    mobil: pesanan.mobil,
                    jadwal: pesanan.jadwal,
                    getStatusColor: _getStatusColor,
                    getStatusIcon: _getStatusIcon,
                    buildStatusButton: _buildStatusButton,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatusButton(
    int jadwalId,
    String status,
    Color color,
    bool isActive,
    IconData icon,
  ) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {
          // Tambahkan aksi ubah status di sini jika perlu
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isActive ? Colors.grey.shade300 : color.withValues(alpha: 0.1),
          foregroundColor: isActive ? Colors.grey.shade700 : color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isActive
                  ? Colors.grey.shade400
                  : color.withValues(alpha: 0.5),
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

class UserStatusCard extends StatelessWidget {
  final String status;
  final String mobil;
  final List<Jadwal> jadwal;
  final String name;
  final Color Function(String) getStatusColor;
  final IconData Function(String) getStatusIcon;
  final Widget Function(
    int id,
    String status,
    Color color,
    bool isSelected,
    IconData icon,
  ) buildStatusButton;

  const UserStatusCard({
    super.key,
    required this.status,
    required this.mobil,
    required this.jadwal,
    required this.name,
    required this.getStatusColor,
    required this.getStatusIcon,
    required this.buildStatusButton,
  });

  @override
  Widget build(BuildContext context) {
    final statusIcon = status == 'success'
        ? const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 14)
        : const Icon(Icons.error, color: Colors.red, size: 14);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.car_rental, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(mobil),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 4),
                const Text(
                  'Status Pembayaran',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                statusIcon,
                const SizedBox(width: 4),
                Text(
                  status,
                  style: TextStyle(
                    color: status == 'success'
                        ? const Color(0xFF4CAF50)
                        : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                "Jadwal Kursus",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xFF536DFE)),
              ),
              children: jadwal.map((j) {
                final statusColor = getStatusColor(j.status);
                final statusIcon = getStatusIcon(j.status);
                final isPast =
                    DateTime.parse(j.tanggal).isBefore(DateTime.now());
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isPast
                              ? Colors.grey.shade100
                              : Colors.transparent,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 16, color: Colors.black54),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "${_formatDate(DateTime.parse(j.tanggal))} - ${j.waktuMulai}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: Row(
                                children: [
                                  Icon(statusIcon,
                                      size: 14, color: statusColor),
                                  const SizedBox(width: 4),
                                  Text(
                                    j.status,
                                    style: TextStyle(
                                      color: statusColor,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.access_time,
                                    size: 16, color: Colors.black54),
                                const SizedBox(width: 8),
                                Text(
                                  "${j.waktuMulai.substring(0, 5)} - ${j.waktuSelesai.substring(0, 5)}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const Spacer(),
                                Text("ID: ${j.id}",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text("Update Status:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 13)),
                            const SizedBox(height: 8),
                            BlocConsumer<UpdateStatusInstruktutBloc,
                                UpdateStatusInstruktutState>(
                              listener: (context, state) {
                                state.maybeWhen(
                                  orElse: () {},
                                  success: (updateStatusResponse) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text(updateStatusResponse.message),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    context
                                        .read<UserStatusBloc>()
                                        .add(UserStatusEvent.userStatus());
                                  },
                                  error: (message) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(message),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                );
                              },
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () {
                                    final request = UpdateRequestStatus(
                                      idJadwal: j.id,
                                      status: 'ongoing',
                                    );
                                    debugPrint(request.status);
                                    debugPrint(request.idJadwal.toString());

                                    context
                                        .read<UpdateStatusInstruktutBloc>()
                                        .add(
                                          UpdateStatusInstruktutEvent
                                              .updateStatus(request),
                                        );
                                  },
                                  child: const Text("Update Status"),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}
