import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/all_pesanan/all_pesanan_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/update_pesanan_status/update_pesanan_status_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/edit_pesanan_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/kasir/all_pesanan_response.dart';
import 'package:kursus_mengemudi_nasional/screens/kasir/pesanan/show_detail_pesanan.dart';

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
          final namaUser = pesanan.namaUser.toLowerCase();
          final namaPaket = pesanan.namaPaket.toLowerCase();
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

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFF6B6B);
      case 'processing':
        return const Color(0xFF4ECDC4);
      case 'success':
        return const Color(0xFF45B7D1);
      default:
        return Colors.grey;
    }
  }

  void editStatus(int pesananId, String currentStatus) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditStatusDialog(
          pesananId: pesananId,
          currentStatus: currentStatus,
          onStatusChanged: (newStatus) {
            context.read<UpdatePesananStatusBloc>().add(
                  UpdatePesananStatusEvent.started(
                    EditPesananRequest(
                      idPesanan: pesananId,
                      status: newStatus,
                    ),
                  ),
                );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePesananStatusBloc, UpdatePesananStatusState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Updating status...'),
              ),
            );
          },
          success: (message) {
            context
                .read<AllPesananBloc>()
                .add(const AllPesananEvent.getAllPesanan());

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message.message),
                backgroundColor: Colors.green,
              ),
            );
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
      child: Scaffold(
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
                          final all = data.data;

                          final total = all.length;
                          final totalPending = all
                              .where((e) => e.status.toLowerCase() == 'pending')
                              .length;
                          final totalProcessing = all
                              .where(
                                  (e) => e.status.toLowerCase() == 'processing')
                              .length;
                          final totalSuccess = all
                              .where((e) => e.status.toLowerCase() == 'success')
                              .length;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem('Total Pesanan', total.toString(),
                                  Icons.shopping_cart),
                              _buildStatItem('Pending', totalPending.toString(),
                                  Icons.pending, Color(0xFFFF6B6B)),
                              _buildStatItem(
                                  'Processing',
                                  totalProcessing.toString(),
                                  Icons.timelapse,
                                  Color(0xFF4ECDC4)),
                              _buildStatItem('Success', totalSuccess.toString(),
                                  Icons.check_circle, Color(0xFF45B7D1)),
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
                        final allPesanan = data.data;

                        final query = searchController.text.toLowerCase();
                        final filtered = query.isEmpty
                            ? allPesanan
                            : allPesanan.where((pesanan) {
                                final namaUser = pesanan.namaUser.toLowerCase();
                                final namaPaket =
                                    pesanan.namaPaket.toLowerCase();
                                return namaUser.contains(query) ||
                                    namaPaket.contains(query);
                              }).toList();

                        return filtered.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off_rounded,
                                      size: 80,
                                      color: Colors.grey[400],
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Tidak ada pesanan ditemukan',
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
                                padding: EdgeInsets.all(20),
                                itemCount: filtered.length,
                                itemBuilder: (context, index) {
                                  final pesanan = filtered[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white,
                                          Colors.grey[50]!,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 20,
                                          offset: Offset(0, 8),
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          blurRadius: 6,
                                          offset: Offset(0, 2),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowPesananScreen(
                                                  pesananId: pesanan.pesananId,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Header with ID and Status
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue[50],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                          color:
                                                              Colors.blue[200]!,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .receipt_long_rounded,
                                                            size: 18,
                                                            color: Colors
                                                                .blue[700],
                                                          ),
                                                          SizedBox(width: 6),
                                                          Text(
                                                            '#${pesanan.pesananId}',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .blue[700],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: getStatusColor(
                                                            pesanan.status),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: getStatusColor(
                                                                    pesanan
                                                                        .status)
                                                                .withOpacity(
                                                                    0.3),
                                                            blurRadius: 8,
                                                            offset:
                                                                Offset(0, 4),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Text(
                                                        pesanan.status
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(height: 20),

                                                // User Info
                                                Container(
                                                  padding: EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[50],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    border: Border.all(
                                                      color: Colors.grey[200]!,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      _buildInfoRow(
                                                        icon: Icons
                                                            .person_rounded,
                                                        label: 'Customer',
                                                        value: pesanan.namaUser,
                                                        iconColor:
                                                            Colors.purple,
                                                      ),
                                                      SizedBox(height: 12),
                                                      _buildInfoRow(
                                                        icon: Icons
                                                            .local_offer_rounded,
                                                        label: 'Paket',
                                                        value:
                                                            pesanan.namaPaket,
                                                        iconColor:
                                                            Colors.orange,
                                                      ),
                                                      SizedBox(height: 12),
                                                      _buildInfoRow(
                                                        icon: Icons
                                                            .directions_car_rounded,
                                                        label: 'Mobil',
                                                        value: pesanan.mobil,
                                                        iconColor: Colors.green,
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(height: 16),

                                                // Time Progress
                                                Container(
                                                  padding: EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.blue[50]!,
                                                        Colors.indigo[50]!,
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    border: Border.all(
                                                      color: Colors.blue[100]!,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Progress Waktu',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .blue[800],
                                                            ),
                                                          ),
                                                          Text(
                                                            '${pesanan.jamTerpakai}/${pesanan.jumlahJamPaket} jam',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .blue[700],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 8),
                                                      LinearProgressIndicator(
                                                        value: pesanan
                                                                .jamTerpakai /
                                                            pesanan
                                                                .jumlahJamPaket,
                                                        backgroundColor:
                                                            Colors.grey[300],
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          pesanan.jamSisa > 0
                                                              ? Colors.blue
                                                              : Colors.red,
                                                        ),
                                                        minHeight: 6,
                                                      ),
                                                      SizedBox(height: 8),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Sisa waktu',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 8,
                                                              vertical: 4,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: pesanan
                                                                          .jamSisa >
                                                                      0
                                                                  ? Colors.green[
                                                                      100]
                                                                  : Colors
                                                                      .red[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: Text(
                                                              '${pesanan.jamSisa} jam',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: pesanan
                                                                            .jamSisa >
                                                                        0
                                                                    ? Colors.green[
                                                                        700]
                                                                    : Colors.red[
                                                                        700],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(height: 20),

                                                // Action Buttons
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height: 48,
                                                        child:
                                                            ElevatedButton.icon(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ShowPesananScreen(
                                                                  pesananId: pesanan
                                                                      .pesananId,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .visibility_rounded,
                                                            size: 20,
                                                          ),
                                                          label: Text(
                                                            'Detail',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .blue[600],
                                                            foregroundColor:
                                                                Colors.white,
                                                            elevation: 0,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 12),
                                                    Expanded(
                                                      child: Container(
                                                        height: 48,
                                                        child:
                                                            OutlinedButton.icon(
                                                          onPressed: () =>
                                                              editStatus(
                                                            pesanan.pesananId,
                                                            pesanan.status,
                                                          ),
                                                          icon: Icon(
                                                            Icons.edit_rounded,
                                                            size: 20,
                                                          ),
                                                          label: Text(
                                                            'Edit Status',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                Colors.indigo[
                                                                    600],
                                                            side: BorderSide(
                                                              color: Colors
                                                                  .indigo[200]!,
                                                              width: 1.5,
                                                            ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
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
            ],
          ),
        ),
      ),
    );
  }

  // Helper method untuk info row (tambahkan di class yang sama)
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: iconColor,
          ),
        ),
        SizedBox(width: 12),
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
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon,
      [Color? color]) {
    return Column(
      children: [
        Icon(icon, color: color ?? Color(0xFF1976D2), size: 24),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color ?? Color(0xFF1976D2),
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
}

class EditStatusDialog extends StatefulWidget {
  final int pesananId;
  final String currentStatus;
  final Function(String) onStatusChanged;

  const EditStatusDialog({
    super.key,
    required this.pesananId,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  @override
  EditStatusDialogState createState() => EditStatusDialogState();
}

class EditStatusDialogState extends State<EditStatusDialog> {
  late String selectedStatus;
  final List<String> statusOptions = ['pending', 'processing', 'success'];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.currentStatus;
  }

  void updateStatus() {
    widget.onStatusChanged(selectedStatus);
    Navigator.pop(context);
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Color(0xFFFF6B6B);
      case 'processing':
        return Color(0xFF4ECDC4);
      case 'success':
        return Color(0xFF45B7D1);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Status Pesanan #${widget.pesananId}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Pilih status baru:'),
          SizedBox(height: 16),
          ...statusOptions.map((status) {
            return RadioListTile<String>(
              title: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: getStatusColor(status),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              value: status,
              groupValue: selectedStatus,
              onChanged: (String? value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: updateStatus,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: Text('Update'),
        ),
      ],
    );
  }
}
