import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/logout/logout_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/update_status_instruktur/update_status_instruktut_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/user_status/user_status_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/request/instruktur/update_status_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/instruktur/user_status.dart';
import 'package:kursus_mengemudi_nasional/screens/auth/login_page.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  // Simple Modern Color Scheme
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color textGray = Color(0xFF64748B);
  static const Color lightGray = Color(0xFFF8FAFC);

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return const Color(0xFFF59E0B);
      case "ongoing":
        return primaryBlue;
      case "completed":
        return const Color(0xFF10B981);
      case "cancelled":
        return const Color(0xFFEF4444);
      default:
        return textGray;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "pending":
        return Icons.schedule;
      case "ongoing":
        return Icons.play_circle_filled;
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
    return BlocConsumer<UpdateStatusInstruktutBloc,
        UpdateStatusInstruktutState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: (res) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(res.message),
                backgroundColor: const Color(0xFF10B981),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            );
            context.read<UserStatusBloc>().add(UserStatusEvent.userStatus());
          },
          error: (msg) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(msg),
                backgroundColor: const Color(0xFFEF4444),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(context),
          body: BlocBuilder<UserStatusBloc, UserStatusState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => _buildLoadingState(),
                success: (data) {
                  final List<Map<String, dynamic>> allData = [];
                  for (var user in data.data) {
                    for (var p in user.pesanan) {
                      allData.add({
                        'username': user.username,
                        'pesanan': p,
                      });
                    }
                  }

                  if (allData.isEmpty) {
                    return _buildEmptyState();
                  }

                  return _buildScheduleList(allData);
                },
              );
            },
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF3B82F6),
      foregroundColor: Colors.white,
      title: const Text(
        "Instruktur Page",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      actions: [
        BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: const Color(0xFFEF4444),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                );
              },
              success: () {
                AuthlocalDatasource().removeLoginData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
            );
          },
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                context.read<LogoutBloc>().add(const LogoutEvent.logout());
              },
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.logout,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryBlue),
        strokeWidth: 2,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 64,
            color: textGray.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada jadwal',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: textGray,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Belum ada jadwal kursus yang tersedia',
            style: TextStyle(
              fontSize: 14,
              color: textGray.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleList(List<Map<String, dynamic>> allData) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: allData.length,
      itemBuilder: (context, index) {
        final username = allData[index]['username'];
        final pesanan = allData[index]['pesanan'];
        return SimpleUserCard(
          name: username,
          status: pesanan.status,
          mobil: pesanan.mobil,
          jadwal: pesanan.jadwal,
          getStatusColor: _getStatusColor,
          getStatusIcon: _getStatusIcon,
        );
      },
    );
  }
}

class SimpleUserCard extends StatelessWidget {
  final String status;
  final String mobil;
  final List<Jadwal> jadwal;
  final String name;
  final Color Function(String) getStatusColor;
  final IconData Function(String) getStatusIcon;

  const SimpleUserCard({
    super.key,
    required this.status,
    required this.mobil,
    required this.jadwal,
    required this.name,
    required this.getStatusColor,
    required this.getStatusIcon,
  });

  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color textGray = Color(0xFF64748B);
  static const Color lightGray = Color(0xFFF8FAFC);
  static const Color borderGray = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderGray),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        mobil,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Schedule List
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jadwal Kursus',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: textGray,
                  ),
                ),
                const SizedBox(height: 16),
                if (jadwal.isNotEmpty)
                  ...jadwal.map((j) => _buildScheduleItem(context, j)),
                if (jadwal.isEmpty)
                  Text(
                    'Jadwal Belum di Tambahkan',
                    style: TextStyle(
                      fontSize: 14,
                      color: textGray.withOpacity(0.7),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(BuildContext context, Jadwal j) {
    final statusColor = getStatusColor(j.status);
    final statusIcon = getStatusIcon(j.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderGray.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  statusIcon,
                  size: 16,
                  color: statusColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDate(DateTime.parse(j.tanggal)),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "${j.waktuMulai.substring(0, 5)} - ${j.waktuSelesai.substring(0, 5)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: textGray,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  j.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: ${j.id}",
                style: TextStyle(
                  fontSize: 11,
                  color: textGray.withOpacity(0.7),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final request = UpdateRequestStatus(
                    idJadwal: j.id,
                    status: 'ongoing',
                  );
                  context.read<UpdateStatusInstruktutBloc>().add(
                        UpdateStatusInstruktutEvent.updateStatus(request),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Selesai",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }
}
