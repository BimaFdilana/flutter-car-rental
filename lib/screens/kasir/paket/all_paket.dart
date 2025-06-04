// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/all_paket/all_paket_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/deleted_paket/deleted_paket_bloc.dart';
import 'package:kursus_mengemudi_nasional/screens/kasir/paket/create_paket.dart';
import 'package:kursus_mengemudi_nasional/screens/kasir/paket/detail_paket.dart';

class AllPaketScreen extends StatefulWidget {
  const AllPaketScreen({super.key});

  @override
  AllPaketScreenState createState() => AllPaketScreenState();
}

class AllPaketScreenState extends State<AllPaketScreen> {
  String formatCurrency(String price) {
    double amount = double.parse(price);
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  void initState() {
    super.initState();
    context.read<AllPaketBloc>().add(AllPaketEvent.started());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeletedPaketBloc, DeletedPaketState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loaded: () {
            // Reload data paket
            context.read<AllPaketBloc>().add(AllPaketEvent.started());

            // Tampilkan Snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Paket berhasil dihapus'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          },
          error: (message) {
            // Jika ada error hapus, tampilkan snackbar error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal menghapus paket: $message'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Semua Paket',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 2,
          shadowColor: Colors.blue.withOpacity(0.3),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFE3F2FD),
                Color(0xFFF5F7FA),
              ],
            ),
          ),
          child: BlocBuilder<AllPaketBloc, AllPaketState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => SizedBox(),
                loaded: (data) {
                  final packages = data.data;
                  return packages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.inbox,
                                  size: 80, color: Colors.grey[400]),
                              SizedBox(height: 16),
                              Text(
                                'Belum ada paket tersedia',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            await Future.delayed(Duration(seconds: 1));
                          },
                          child: ListView.builder(
                            padding: EdgeInsets.all(16),
                            itemCount: packages.length,
                            itemBuilder: (context, index) {
                              final package = packages[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Card(
                                  elevation: 4,
                                  shadowColor: Colors.blue.withOpacity(0.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPaketScreen(
                                                  pesananId: package.id),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.white,
                                            Color(0xFFF8FBFF),
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF2196F3)
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  Icons.card_giftcard,
                                                  color: Color(0xFF2196F3),
                                                  size: 24,
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  package.namaPaket,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF1976D2),
                                                  ),
                                                ),
                                              ),
                                              // deleted button
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.red
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: IconButton(
                                                  icon: Icon(Icons.delete),
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text(
                                                            'Konfirmasi Hapus'),
                                                        content: Text(
                                                            'Apakah Anda yakin ingin menghapus paket ini?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                Text('Batal'),
                                                          ),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.red,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context); // Tutup dialog
                                                              context
                                                                  .read<
                                                                      DeletedPaketBloc>()
                                                                  .add(
                                                                    DeletedPaketEvent
                                                                        .started(
                                                                            package.id),
                                                                  );
                                                            },
                                                            child:
                                                                Text('Hapus'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            package.deskripsi,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                              height: 1.4,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF4CAF50)
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  '${package.jumlahJam} Jam',
                                                  style: TextStyle(
                                                    color: Color(0xFF4CAF50),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                formatCurrency(package.harga),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF1976D2),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreatePaketScreen()),
            );
          },
          icon: Icon(Icons.add),
          label: Text('Tambah Paket'),
          backgroundColor: Color(0xFF2196F3),
          elevation: 4,
        ),
      ),
    );
  }
}
