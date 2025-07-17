import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/add_paket/add_paket_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/all_paket/all_paket_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/create_paket_request.dart';

class CreatePaketScreen extends StatefulWidget {
  const CreatePaketScreen({super.key});

  @override
  CreatePaketScreenState createState() => CreatePaketScreenState();
}

class CreatePaketScreenState extends State<CreatePaketScreen> {
  bool _isLoadingShown = false;
  final _formKey = GlobalKey<FormState>();
  final _namaPaketController = TextEditingController();
  final _jumlahJamController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _hargaController = TextEditingController();
  final _noRekeningController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPaketBloc, AddPaketState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loading: () {
            if (!_isLoadingShown) {
              _isLoadingShown = true;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => Center(child: CircularProgressIndicator()),
              );
            }
          },
          loaded: (data) {
            if (_isLoadingShown) {
              Navigator.pop(context); // Tutup dialog loading
              _isLoadingShown = false;
            }

            Navigator.pop(context, true);
            context.read<AllPaketBloc>().add(AllPaketEvent.started());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(data.message), backgroundColor: Colors.green),
            );
          },
          error: (message) {
            if (_isLoadingShown) {
              Navigator.pop(context); // Tutup dialog loading
              _isLoadingShown = false;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambah Paket Baru'),
          centerTitle: true,
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
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Card(
              elevation: 8,
              shadowColor: Colors.blue.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Color(0xFFF8FBFF),
                    ],
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFF2196F3).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.add_box,
                            color: Color(0xFF2196F3),
                            size: 48,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      _buildTextField(
                        controller: _namaPaketController,
                        label: 'Nama Paket',
                        icon: Icons.card_giftcard,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama paket harus diisi';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        controller: _jumlahJamController,
                        label: 'Jumlah Jam',
                        icon: Icons.access_time,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Jumlah jam harus diisi';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        controller: _noRekeningController,
                        label: 'No Rekening',
                        icon: Icons.account_balance_wallet,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No rekening harus diisi';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        controller: _hargaController,
                        label: 'Harga',
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harga harus diisi';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        controller: _deskripsiController,
                        label: 'Deskripsi',
                        icon: Icons.description,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi harus diisi';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Simulate creating package
                            final request = CreatePaketRequest(
                              namaPaket: _namaPaketController.text,
                              jumlahJam: _jumlahJamController.text,
                              noRekening: _noRekeningController.text,
                              harga: _hargaController.text,
                              deskripsi: _deskripsiController.text,
                            );
                            BlocProvider.of<AddPaketBloc>(context).add(
                              AddPaketEvent.started(request),
                            );
                          }
                        },
                        icon: Icon(Icons.save),
                        label: Text('Simpan Paket'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2196F3),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF2196F3)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF2196F3).withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF2196F3), width: 2),
        ),
        filled: true,
        fillColor: Color(0xFFF8FBFF),
        labelStyle: TextStyle(color: Color(0xFF2196F3)),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
    );
  }
}
