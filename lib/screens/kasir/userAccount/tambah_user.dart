import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/add_user/add_user_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/all_user/all_user_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/request/kasir/add_user.dart';

class TambahUser extends StatefulWidget {
  const TambahUser({super.key});

  @override
  State<TambahUser> createState() => _TambahUserState();
}

class _TambahUserState extends State<TambahUser> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _passwordController = TextEditingController();
  final _teleponController = TextEditingController();

  final Map<String, String> _rolesMap = {
    'Siswa': 'Student',
    'Instruktur': 'Instructor',
  };

  late String _selectedRole; // default di initState

  @override
  void initState() {
    super.initState();
    _selectedRole = _rolesMap.keys.first; // default: 'Siswa'
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddUserBloc, AddUserState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loaded: (response) {
            if (response.success) {
              Navigator.pop(context);
              context.read<AllUserBloc>().add(AllUserEvent.started());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response.message),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambah User'),
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
              // Header
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
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.person_add,
                        color: Color(0xFF1976D2),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tambah User Baru',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                          Text(
                            'Daftarkan user baru ke sistem',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Form
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
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
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Lengkap
                          Text(
                            'Nama Lengkap',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _namaController,
                            decoration: InputDecoration(
                              hintText: 'Masukkan nama lengkap',
                              prefixIcon:
                                  Icon(Icons.person, color: Color(0xFF1976D2)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Color(0xFF1976D2)
                                        .withValues(alpha: 0.3)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Color(0xFF1976D2), width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama lengkap harus diisi';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Telepon
                          Text(
                            'Nomor Telepon',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _teleponController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Masukkan nomor telepon',
                              prefixIcon:
                                  Icon(Icons.phone, color: Color(0xFF1976D2)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Color(0xFF1976D2)
                                        .withValues(alpha: 0.3)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Color(0xFF1976D2), width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nomor telepon harus diisi';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Email
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: 'Masukkan password',
                              prefixIcon:
                                  Icon(Icons.lock, color: Color(0xFF1976D2)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Color(0xFF1976D2)
                                        .withValues(alpha: 0.3)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Color(0xFF1976D2), width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password harus diisi';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Role
                          Text(
                            'Role',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Color(0xFF1976D2).withValues(alpha: 0.3)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedRole,
                              isExpanded: true,
                              underline: SizedBox(),
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Color(0xFF1976D2)),
                              items: _rolesMap.keys.map((String role) {
                                return DropdownMenuItem<String>(
                                  value: role,
                                  child: Row(
                                    children: [
                                      Icon(_getRoleIcon(role),
                                          color: Color(0xFF1976D2), size: 20),
                                      SizedBox(width: 12),
                                      Text(role),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedRole = newValue!;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 30),

                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                final request = UserRequest(
                                  username: _namaController.text,
                                  noHp: _teleponController.text,
                                  password: _passwordController.text,
                                  role: _selectedRole,
                                );
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<AddUserBloc>()
                                      .add(AddUserEvent.started(request));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1976D2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Tambah User',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case 'Siswa':
        return Icons.school;
      case 'Instruktur':
        return Icons.person;
      default:
        return Icons.person;
    }
  }

  void _clearForm() {
    _namaController.clear();
    _passwordController.clear();
    _teleponController.clear();
    setState(() {
      _selectedRole = 'Siswa';
    });
  }

  @override
  void dispose() {
    _namaController.dispose();
    _passwordController.dispose();
    _teleponController.dispose();
    super.dispose();
  }
}
