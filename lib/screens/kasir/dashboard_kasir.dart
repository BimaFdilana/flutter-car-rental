// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/logout/logout_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/screens/kasir/all_pesanan.dart';
import 'package:kursus_mengemudi_nasional/screens/kasir/change_status_kursus.dart';
import 'package:kursus_mengemudi_nasional/screens/kasir/edit_status_pesanan.dart';
import 'package:kursus_mengemudi_nasional/screens/kasir/show_all_jadwal.dart';
import 'package:kursus_mengemudi_nasional/screens/kasir/show_all_user.dart';
import 'package:kursus_mengemudi_nasional/screens/kasir/tambah_user.dart';
import 'package:kursus_mengemudi_nasional/screens/siswa/login_page.dart';

class DashboardKasir extends StatelessWidget {
  const DashboardKasir({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
              Color(0xFFF5F7FA),
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dashboard Kasir',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Management System',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        BlocListener<LogoutBloc, LogoutState>(
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
                                        builder: (context) =>
                                            const LoginPage()),
                                    (route) => false);
                              },
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              context.read<LogoutBloc>().add(
                                  const LogoutEvent.logout());
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Menu Grid
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildMenuCard(
                        context,
                        'Data Pesanan',
                        Icons.shopping_cart_outlined,
                        Color(0xFF2196F3),
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllPesanan())),
                      ),
                      _buildMenuCard(
                        context,
                        'Edit Status Pesanan',
                        Icons.edit_outlined,
                        Color(0xFF1976D2),
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditStatusPesanan())),
                      ),
                      _buildMenuCard(
                        context,
                        'Jadwal Kursus',
                        Icons.schedule_outlined,
                        Color(0xFF0D47A1),
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowAllJadwal())),
                      ),
                      _buildMenuCard(
                        context,
                        'Status Kursus',
                        Icons.school_outlined,
                        Color(0xFF1565C0),
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeStatusKursus())),
                      ),
                      _buildMenuCard(
                        context,
                        'Tambah User',
                        Icons.person_add_outlined,
                        Color(0xFF42A5F5),
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TambahUser())),
                      ),
                      _buildMenuCard(
                        context,
                        'Semua User',
                        Icons.people_outlined,
                        Color(0xFF64B5F6),
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserListScreen())),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              color.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
