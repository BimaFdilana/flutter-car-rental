import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/cart_item.dart';
import '../utils/theme.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<CartItem> _cartItems = [];
  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if there's a new cart item passed from the schedule page
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is CartItem && !_cartItems.contains(args)) {
      setState(() {
        _cartItems.add(args);
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _checkout() {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keranjang masih kosong'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // In a real app, implement checkout logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pemesanan Berhasil'),
        content: const Text(
          'Terima kasih telah memesan kursus mengemudi di NASIONAL Kursus Mengemudi. '
          'Tim kami akan segera menghubungi Anda untuk konfirmasi.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacementNamed(context, '/packages');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  double _calculateTotal() {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: _cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Keranjang Anda kosong',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Silakan pilih paket kursus terlebih dahulu',
                    style: TextStyle(
                      color: AppTheme.lightTextColor,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Package Type
                                        Text(
                                          item.packageType,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.textColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Price
                                        Text(
                                          currencyFormat.format(item.price),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.accentColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Remove button
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _removeItem(index),
                                  ),
                                ],
                              ),
                              const Divider(height: 24),
                              // Schedule info
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: AppTheme.primaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    DateFormat('EEEE, d MMMM yyyy', 'id_ID')
                                        .format(item.scheduledDate),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.textColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Time info
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: AppTheme.primaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    item.startTime.format(context),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.textColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Payment method
                              Row(
                                children: [
                                  Icon(
                                    item.paymentMethod == 'Bayar di Tempat'
                                        ? Icons.money
                                        : item.paymentMethod == 'Transfer Bank'
                                            ? Icons.account_balance
                                            : item.paymentMethod == 'QRIS'
                                                ? Icons.qr_code
                                                : Icons.account_balance_wallet,
                                    size: 16,
                                    color: AppTheme.primaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    item.paymentMethod,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Summary and Checkout Button
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textColor,
                            ),
                          ),
                          Text(
                            currencyFormat.format(_calculateTotal()),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.accentColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _checkout,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: AppTheme.accentColor,
                          ),
                          child: const Text('CHECKOUT'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
