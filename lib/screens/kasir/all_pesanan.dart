import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/all_pesanan/all_pesanan_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_pesanan_response.dart';
import 'package:kursus_mengemudi_nasional/utils/api.dart';

class AllPesanan extends StatefulWidget {
  const AllPesanan({super.key});

  @override
  State<AllPesanan> createState() => _AllPesananState();
}

class _AllPesananState extends State<AllPesanan> {
  List<Datum> allPesanan = [];
  List<Datum> filteredPesanan = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AllPesananBloc>().add(const AllPesananEvent.getAllPesanan());

    searchController.addListener(() {
      filterPesanan();
    });
  }

  void filterPesanan() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        filteredPesanan = allPesanan;
      });
    } else {
      setState(() {
        filteredPesanan = allPesanan.where((pesanan) {
          // Contoh filter berdasarkan namaUser dan namaPaket
          final namaUser = pesanan.namaUser?.toLowerCase() ?? '';
          final namaPaket = pesanan.namaPaket?.toLowerCase() ?? '';
          return namaUser.contains(query) || namaPaket.contains(query);
        }).toList();
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pesanan'),
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
                      color: Colors.blue.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: BlocBuilder<AllPesananBloc, AllPesananState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const SizedBox(),
                      success: (data) {
                        final all = data.data ?? [];

                        final total = all.length;
                        final totalPending = all
                            .where((e) => e.status?.toLowerCase() == 'pending')
                            .length;
                        final totalProcessing = all
                            .where(
                                (e) => e.status?.toLowerCase() == 'processing')
                            .length;
                        final totalSuccess = all
                            .where((e) => e.status?.toLowerCase() == 'success')
                            .length;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem('Total Pesanan', total.toString(),
                                Icons.shopping_cart),
                            _buildStatItem('Pending', totalPending.toString(),
                                Icons.pending),
                            _buildStatItem('Processing',
                                totalProcessing.toString(), Icons.timelapse),
                            _buildStatItem('Completed', totalSuccess.toString(),
                                Icons.check_circle),
                          ],
                        );
                      },
                    );
                  },
                )),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Cari pesanan...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Color(0xFF1976D2)),
                ),
              ),
            ),

            SizedBox(height: 16),

            // Pesanan List
            Expanded(
              child: BlocBuilder<AllPesananBloc, AllPesananState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox(),
                    success: (data) {
                      allPesanan = data.data!;
                      if (filteredPesanan.isEmpty) {
                        filteredPesanan = allPesanan;
                      }
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredPesanan.length,
                        itemBuilder: (context, index) {
                          final pesanan = filteredPesanan[index];
                          final imageUrl =
                              '${BaseUrl.storage}${pesanan.buktiPembayaran}';
                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Pesanan ID : ${pesanan.pesananId.toString()}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1976D2),
                                        ),
                                      ),
                                      _buildStatusChip(pesanan.status!),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    pesanan.namaUser!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    pesanan.namaPaket!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Jumlah Jam Paket : ${pesanan.jumlahJamPaket}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  // Tambahkan ini
                                  Text(
                                    'Bukti Pembayaran :',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  if (pesanan.buktiPembayaran != null &&
                                      pesanan.buktiPembayaran!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => Dialog(
                                              child: InteractiveViewer(
                                                child: Image.network(
                                                  imageUrl,
                                                  fit: BoxFit.contain,
                                                  errorBuilder: (_, __, ___) =>
                                                      Center(
                                                          child: Text(
                                                              "Gagal memuat gambar")),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            imageUrl,
                                            height: 100,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                Center(
                                                    child: Text(
                                                        "Gagal memuat gambar")),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            //exp
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

  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status) {
      case 'pending':
        chipColor = Colors.orange;
        break;
      case 'processing':
        chipColor = Colors.blue;
        break;
      case 'success':
        chipColor = Colors.green;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: chipColor.withValues(alpha: 0.3)),
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
}
