import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kursus_mengemudi_nasional/logic/user_status/user_status_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/response/instruktur/user_status.dart';

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
      ),
      body: BlocBuilder<UserStatusBloc, UserStatusState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => Center(
              child: CircularProgressIndicator(),
            ),
            success: (data) {
              return UserStatusCard(
                data: data.data,
                getStatusColor: _getStatusColor,
                getStatusIcon: _getStatusIcon,
                buildStatusButton: _buildStatusButton,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatusButton(
      int jadwalId, String status, Color color, bool isActive, IconData icon) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {},
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

class UserStatusCard extends StatelessWidget {
  final Data data;
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
    required this.data,
    required this.getStatusColor,
    required this.getStatusIcon,
    required this.buildStatusButton,
  });

  @override
  Widget build(BuildContext context) {
    final jadwalList = data.jadwal;
    final statusIcon = data.status == 'success'
        ? const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 14)
        : const Icon(Icons.error, color: Colors.red, size: 14);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
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
                        "Paket: ${data.paket}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [
                        statusIcon,
                        const SizedBox(width: 4),
                        Text(
                          data.status,
                          style: TextStyle(
                            color: data.status == 'success'
                                ? const Color(0xFF4CAF50)
                                : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.car_rental, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(data.mobil),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Jadwal Kursus",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color(0xFF536DFE)),
                ),
                const SizedBox(height: 12),
                ...jadwalList.map((jadwal) {
                  final statusColor = getStatusColor(jadwal.status);
                  final statusIcon = getStatusIcon(jadwal.status);
                  final isPast = jadwal.tanggal.isBefore(DateTime.now());

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
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
                                  "${_formatDate(jadwal.tanggal)} - ${jadwal.waktuMulai}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
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
                                      jadwal.status,
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
                                    "${jadwal.waktuMulai.substring(0, 5)} - ${jadwal.waktuSelesai.substring(0, 5)}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const Spacer(),
                                  Text("ID: ${jadwal.id}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600])),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text("Update Status:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  buildStatusButton(
                                    jadwal.id,
                                    "pending",
                                    const Color(0xFFFF9800),
                                    jadwal.status == "pending",
                                    Icons.timelapse,
                                  ),
                                  const SizedBox(width: 8),
                                  buildStatusButton(
                                    jadwal.id,
                                    "completed",
                                    const Color(0xFF4CAF50),
                                    jadwal.status == "completed",
                                    Icons.check_circle,
                                  ),
                                  const SizedBox(width: 8),
                                  buildStatusButton(
                                    jadwal.id,
                                    "cancelled",
                                    const Color(0xFFF44336),
                                    jadwal.status == "cancelled",
                                    Icons.cancel,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        )
      ],
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}


