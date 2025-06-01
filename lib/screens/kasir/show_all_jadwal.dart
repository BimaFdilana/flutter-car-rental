import 'package:flutter/material.dart';

class ShowAllJadwal extends StatefulWidget {
  const ShowAllJadwal({super.key});

  @override
  State<ShowAllJadwal> createState() => _ShowAllJadwalState();
}

class _ShowAllJadwalState extends State<ShowAllJadwal>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> scheduleData = [
    {
      "id": 1,
      "pesanan_id": 1,
      "instruktur_id": 2,
      "tanggal": "2025-05-21",
      "waktu_mulai": "14:31:06",
      "waktu_selesai": "16:31:06",
      "status": "pending",
      "created_at": "2025-05-09T14:31:06.000000Z",
      "updated_at": "2025-05-09T14:31:06.000000Z",
      "pesanan": {
        "id": 1,
        "user_id": 3,
        "paket_id": 1,
        "mobil": "Suzuki Ertiga",
        "bukti_pembayaran": "buktipembayaran/pHQMWRSPl6Wk7uqMTU0I.jpg",
        "status": "success",
        "created_at": "2025-05-09T14:31:06.000000Z",
        "updated_at": "2025-05-09T14:32:25.000000Z"
      },
      "instruktur": {
        "id": 2,
        "name": "Instruktur Ahmad",
        "username": "instruktur",
        "no_hp": "081234567891",
        "email": "instruktur@example.com",
        "email_verified_at": "2025-05-09T14:31:05.000000Z",
        "created_at": "2025-05-09T14:31:05.000000Z",
        "updated_at": "2025-05-09T14:31:05.000000Z"
      }
    },
    {
      "id": 2,
      "pesanan_id": 2,
      "instruktur_id": 3,
      "tanggal": "2025-05-22",
      "waktu_mulai": "10:00:00",
      "waktu_selesai": "12:00:00",
      "status": "confirmed",
      "created_at": "2025-05-10T10:00:00.000000Z",
      "updated_at": "2025-05-10T10:00:00.000000Z",
      "pesanan": {
        "id": 2,
        "user_id": 4,
        "paket_id": 2,
        "mobil": "Toyota Avanza",
        "bukti_pembayaran": "buktipembayaran/example2.jpg",
        "status": "success",
        "created_at": "2025-05-10T10:00:00.000000Z",
        "updated_at": "2025-05-10T10:00:00.000000Z"
      },
      "instruktur": {
        "id": 3,
        "name": "Instruktur Budi",
        "username": "instruktur_budi",
        "no_hp": "081234567892",
        "email": "budi@example.com",
        "email_verified_at": "2025-05-10T10:00:00.000000Z",
        "created_at": "2025-05-10T10:00:00.000000Z",
        "updated_at": "2025-05-10T10:00:00.000000Z"
      }
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.schedule;
      case 'confirmed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  String formatTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = parts[1];
    return '${hour.toString().padLeft(2, '0')}:$minute';
  }

  String formatDate(String date) {
    final dateTime = DateTime.parse(date);
    final months = [
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
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF667eea),
                      Color(0xFF764ba2),
                    ],
                  ),
                ),
                child: const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Jadwal Kursus',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Kelola jadwal mengemudi Anda',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: List.generate(scheduleData.length, (index) {
                    final schedule = scheduleData[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ScheduleCard(
                        schedule: schedule,
                        formatTime: formatTime,
                        formatDate: formatDate,
                        getStatusColor: getStatusColor,
                        getStatusIcon: getStatusIcon,
                        animationDelay: index * 200,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleCard extends StatefulWidget {
  final Map<String, dynamic> schedule;
  final String Function(String) formatTime;
  final String Function(String) formatDate;
  final Color Function(String) getStatusColor;
  final IconData Function(String) getStatusIcon;
  final int animationDelay;

  const ScheduleCard({
    super.key,
    required this.schedule,
    required this.formatTime,
    required this.formatDate,
    required this.getStatusColor,
    required this.getStatusIcon,
    required this.animationDelay,
  });

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _cardAnimationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _cardAnimationController,
      curve: Curves.easeOutBack,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _cardAnimationController,
      curve: Curves.easeOutBack,
    ));

    // Delayed animation start
    Future.delayed(Duration(milliseconds: widget.animationDelay), () {
      if (mounted) {
        _cardAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pesanan = widget.schedule['pesanan'];
    final instruktur = widget.schedule['instruktur'];
    final status = widget.schedule['status'];

    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Color(0xFFF8F9FA)],
                ),
              ),
              child: Column(
                children: [
                  // Header with status
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: widget.getStatusColor(status).withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: widget.getStatusColor(status),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            widget.getStatusIcon(status),
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jadwal #${widget.schedule['id']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D3748),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.getStatusColor(status),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  status.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Date and Time
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoTile(
                                Icons.calendar_today,
                                'Tanggal',
                                widget.formatDate(widget.schedule['tanggal']),
                                Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildInfoTile(
                                Icons.access_time,
                                'Waktu',
                                '${widget.formatTime(widget.schedule['waktu_mulai'])} - ${widget.formatTime(widget.schedule['waktu_selesai'])}',
                                Colors.purple,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Instructor and Car
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoTile(
                                Icons.person,
                                'Instruktur',
                                instruktur['name'],
                                Colors.green,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildInfoTile(
                                Icons.directions_car,
                                'Mobil',
                                pesanan['mobil'],
                                Colors.orange,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.phone),
                                label: const Text('Hubungi'),
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                                label: const Text('Edit'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF667eea),
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(
      IconData icon, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF2D3748),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
