import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/logout/logout_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/orderProduct/order_product_bloc.dart';
import 'package:kursus_mengemudi_nasional/logic/product/product_bloc.dart';
import 'package:kursus_mengemudi_nasional/models/local/login_local.dart';
import 'package:kursus_mengemudi_nasional/models/request/siswa/order_product_request.dart';
import 'package:kursus_mengemudi_nasional/models/response/siswa/product_response.dart';
import 'package:kursus_mengemudi_nasional/utils/constants.dart';
import '../utils/theme.dart';
import 'package:intl/intl.dart';

class PackagePage extends StatefulWidget {
  const PackagePage({super.key});

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const ProductEvent.getProducts());
  }

  void _navigateToSchedulePage(Datum package) {
    Navigator.pushNamed(context, '/schedule', arguments: package);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paket Kursus Mengemudi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          BlocConsumer<LogoutBloc, LogoutState>(
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
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
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
                icon: const Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return state.maybeWhen(
            initial: () => const Center(child: Text('Silahkan memuat data')),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text('Error: $message')),
            success: (data) => _buildProductList(data),
            orElse: () => const Center(child: Text('Terjadi kesalahan')),
          );
        },
      ),
    );
  }

  Widget _buildProductList(AllProductResponseModel data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Paket Kursus',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Kami menawarkan paket belajar yang sesuai dengan kebutuhan Anda',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.lightTextColor,
              ),
            ),
            const SizedBox(height: 24),

            // Package Cards
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.data.length,
              itemBuilder: (context, index) {
                final package = data.data[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Package Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            package.namaPaket,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Package Details
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Price and Duration
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color:
                                        AppTheme.accentColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    currencyFormat
                                        .format(double.parse(package.harga)),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.accentColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "${package.jumlahJam} jam",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Schedule
                            const Text(
                              'Jadwal Belajar:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: const [
                                Icon(
                                  Icons.access_time,
                                  size: 18,
                                  color: AppTheme.lightTextColor,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '08.00 - 16.00 WIB',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.textColor,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Deskripsi
                            const Text(
                              'Deskripsi:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              package.deskripsi,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textColor,
                              ),
                            ),

                            const SizedBox(height: 16),

                            const Text(
                              'Kendaraan:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: Constants.cars.map((car) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.directions_car,
                                        size: 16,
                                        color: AppTheme.textColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        car,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 16),

                            const Text(
                              'Metode Pembelajaran:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Constants.learningMethods.map((method) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        size: 16,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          method,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppTheme.textColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 24),

                            // Book Button
                            BlocConsumer<OrderProductBloc, OrderProductState>(
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
                                  success: (dataOrder) {
                                    Navigator.pushNamed(
                                      context,
                                      '/cart',
                                      arguments: dataOrder,
                                    );
                                  },
                                );
                              },
                              builder: (context, state) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      debugPrint('PILIH PAKET');
                                      final request = OrderProdukRequestModel(
                                        idPaket: package.id,
                                        mobil: Constants.cars.first,
                                      );
                                      context.read<OrderProductBloc>().add(
                                          OrderProductEvent.orderProduct(
                                              request));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.secondaryColor,
                                    ),
                                    child: const Text('PILIH PAKET'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
