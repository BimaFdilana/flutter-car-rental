import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/order_data/order_data_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/jadwal_convert.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/order_product_response.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderDataBloc>().add(const OrderDataEvent.getOrderData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent.shade700,
        title: const Text(
          'Detail Pesanan',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              context
                  .read<OrderDataBloc>()
                  .add(const OrderDataEvent.getOrderData());
            },
          ),
        ],
      ),
      body: BlocConsumer<OrderDataBloc, OrderDataState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            initial: () => _buildEmptyState(
              icon: Icons.inbox_rounded,
              message: 'Belum ada data pesanan',
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            ),
            loaded: (data) {
              final pesanan = data.pesanan;
              return _buildOrderDetails(pesanan);
            },
            error: (message) => _buildEmptyState(
              icon: Icons.error_outline_rounded,
              message: 'Keranjang Kosong',
              showRefresh: true,
            ),
            orElse: () => _buildEmptyState(
              icon: Icons.help_outline_rounded,
              message: 'Status tidak dikenali',
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String message,
    bool showRefresh = false,
  }) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetails(Pesanan pesanan) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderProgress(pesanan),
            const SizedBox(height: 24),
            _buildOrderDetailCard(pesanan),
            const SizedBox(height: 16),
            if (pesanan.buktiPembayaran == null) _buildUploadProof(),
            if (pesanan.buktiPembayaran != null &&
                pesanan.status.toLowerCase() != 'completed')
              _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderProgress(Pesanan pesanan) {
    // Calculate progress percentage
    double totalJam = double.tryParse(pesanan.jumlahJamPaket.toString()) ?? 0;
    double terpakai = double.tryParse(pesanan.totalJamTerpakai.toString()) ?? 0;
    double progressPercentage = totalJam > 0 ? terpakai / totalJam : 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progress Kursus',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildStatusChip(pesanan.status),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: progressPercentage,
            backgroundColor: Colors.grey[200],
            valueColor:
                AlwaysStoppedAnimation<Color>(_getStatusColor(pesanan.status)),
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProgressStat(
                label: 'Terpakai',
                value: '${pesanan.totalJamTerpakai} Jam',
                color: Colors.blueAccent,
              ),
              _buildProgressStat(
                label: 'Sisa',
                value: '${pesanan.sisaJam} Jam',
                color: Colors.orangeAccent,
              ),
              _buildProgressStat(
                label: 'Total',
                value: '${pesanan.jumlahJamPaket} Jam',
                color: Colors.greenAccent[700]!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStat({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderDetailCard(Pesanan pesanan) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.directions_car_rounded,
                  color: Colors.blueAccent[700],
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Informasi Pesanan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDetailRow(
                  icon: Icons.receipt_rounded,
                  label: 'ID Pesanan',
                  value: '${pesanan.id}',
                ),
                _buildDivider(),
                _buildDetailRow(
                  icon: Icons.inventory_2_rounded,
                  label: 'ID Paket',
                  value: pesanan.paket,
                ),
                _buildDivider(),
                _buildDetailRow(
                  icon: Icons.timer_rounded,
                  label: 'Jumlah Jam',
                  value: '${pesanan.jumlahJamPaket} jam',
                ),
                _buildDivider(),
                _buildDetailRow(
                  icon: Icons.directions_car_filled_rounded,
                  label: 'Mobil',
                  value: pesanan.mobil != null
                      ? 'Daihatsu Xenia'
                      : 'Toyota Avanza',
                ),
                _buildDivider(),
                _buildDetailJadwalRowList(
                  icon: Icons.event_rounded,
                  label: 'Jadwal',
                  listJadwal: pesanan.jadwal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailJadwalRowList({
    required IconData icon,
    required String label,
    required List<Jadwal> listJadwal,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                // Cek apakah jadwal kosong
                if (listJadwal.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Tidak ada jadwal tersedia',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[500],
                      ),
                    ),
                  )
                else
                  ...listJadwal.map((jadwal) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: [
                            _buildScheduleItem(
                                jadwal.tanggal,
                                jadwal.status,
                                jadwal.durasiJam.toStringAsFixed(1),
                                jadwal.waktuMulai,
                                jadwal.tanggal,
                                jadwal.waktuSelesai),
                          ],
                        ),
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String time, String status, String durasi,
      String waktuMulai, String tanggal, String waktuSelesai) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Durasi',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                '$durasi Jam',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Waktu Mulai',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "$waktuMulai WIB",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Tanggal',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                tanggal,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Waktu Selesai',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "$waktuSelesai WIB",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[200],
      thickness: 1,
      height: 1,
    );
  }

  Widget _buildStatusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(status),
            size: 14,
            color: _getStatusColor(status),
          ),
          const SizedBox(width: 6),
          Text(
            _getFormattedStatus(status),
            style: TextStyle(
              color: _getStatusColor(status),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _getFormattedStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Menunggu';
      case 'completed':
        return 'Selesai';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return status;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.schedule_rounded;
      case 'completed':
        return Icons.check_circle_rounded;
      case 'cancelled':
        return Icons.cancel_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orangeAccent;
      case 'completed':
        return Colors.greenAccent[700]!;
      case 'cancelled':
        return Colors.redAccent;
      default:
        return Colors.blueAccent;
    }
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // Implement jadwalkan action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.calendar_month_rounded),
              label: const Text(
                'Jadwalkan Kursus',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            child: IconButton(
              onPressed: () {
                // Implement contact support
              },
              icon: const Icon(
                Icons.support_agent_rounded,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadProof() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.car_crash_outlined),
              label: const Text(
                'Unggah Bukti Pembayaran',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.payment,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
