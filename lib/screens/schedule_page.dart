// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../utils/constants.dart';
// import '../utils/theme.dart';
// import '../models/cart_item.dart';

// class SchedulePage extends StatefulWidget {
//   const SchedulePage({super.key});

//   @override
//   State<SchedulePage> createState() => _SchedulePageState();
// }

// class _SchedulePageState extends State<SchedulePage> {
//   final NumberFormat currencyFormat = NumberFormat.currency(
//     locale: 'id',
//     symbol: 'Rp ',
//     decimalDigits: 0,
//   );

//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;
//   String paymentMethod = 'Bayar di Tempat';

//   final List<String> paymentMethods = [
//     'Bayar di Tempat',
//     'Transfer Bank',
//     'QRIS',
//     'E-Wallet',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Set default date to tomorrow
//     selectedDate = DateTime.now().add(const Duration(days: 1));
//     // Set default time to 9:00 AM
//     selectedTime = const TimeOfDay(hour: 9, minute: 0);
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate!,
//       firstDate: DateTime.now().add(const Duration(days: 1)),
//       lastDate: DateTime.now().add(const Duration(days: 90)),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppTheme.primaryColor,
//               onPrimary: Colors.white,
//               onSurface: AppTheme.textColor,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime!,
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppTheme.primaryColor,
//               onPrimary: Colors.white,
//               onSurface: AppTheme.textColor,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && picked != selectedTime) {
//       setState(() {
//         selectedTime = picked;
//       });
//     }
//   }

//   void _addToCart(CoursePackage package) {
//     if (selectedDate == null || selectedTime == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Silakan pilih tanggal dan waktu terlebih dahulu'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     // In a real app, create a cart provider to manage cart items
//     final cartItem = CartItem(
//       packageType: package.type,
//       price: package.price,
//       scheduledDate: selectedDate!,
//       startTime: selectedTime!,
//       paymentMethod: paymentMethod,
//     );

//     // Navigate to cart page and pass the cart item
//     Navigator.pushNamed(context, '/cart', arguments: cartItem);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final CoursePackage package =
//         ModalRoute.of(context)!.settings.arguments as CoursePackage;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Jadwal Kursus'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Package Summary
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       package.type,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: AppTheme.textColor,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Text(
//                           currencyFormat.format(package.price),
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppTheme.accentColor,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           '(${package.duration})',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: AppTheme.lightTextColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.access_time,
//                           size: 16,
//                           color: AppTheme.lightTextColor,
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           package.schedule,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: AppTheme.textColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),

//             // Date Picker
//             const Text(
//               'Pilih Tanggal Kursus',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: AppTheme.textColor,
//               ),
//             ),
//             const SizedBox(height: 8),
//             InkWell(
//               onTap: () => _selectDate(context),
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.calendar_today,
//                       color: AppTheme.primaryColor,
//                     ),
//                     const SizedBox(width: 16),
//                     Text(
//                       selectedDate != null
//                           ? DateFormat('EEEE, d MMMM yyyy', 'id_ID')
//                               .format(selectedDate!)
//                           : 'Pilih Tanggal',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: AppTheme.textColor,
//                       ),
//                     ),
//                     const Spacer(),
//                     const Icon(
//                       Icons.arrow_forward_ios,
//                       size: 16,
//                       color: AppTheme.lightTextColor,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Time Picker
//             const Text(
//               'Pilih Waktu Mulai',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: AppTheme.textColor,
//               ),
//             ),
//             const SizedBox(height: 8),
//             InkWell(
//               onTap: () => _selectTime(context),
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.access_time,
//                       color: AppTheme.primaryColor,
//                     ),
//                     const SizedBox(width: 16),
//                     Text(
//                       selectedTime != null
//                           ? selectedTime!.format(context)
//                           : 'Pilih Waktu',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: AppTheme.textColor,
//                       ),
//                     ),
//                     const Spacer(),
//                     const Icon(
//                       Icons.arrow_forward_ios,
//                       size: 16,
//                       color: AppTheme.lightTextColor,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),

//             // Payment Method
//             const Text(
//               'Metode Pembayaran',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: AppTheme.textColor,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   isExpanded: true,
//                   value: paymentMethod,
//                   icon: const Icon(Icons.arrow_drop_down),
//                   iconSize: 24,
//                   elevation: 16,
//                   style: const TextStyle(color: AppTheme.textColor),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       paymentMethod = newValue!;
//                     });
//                   },
//                   items: paymentMethods
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Row(
//                         children: [
//                           Icon(
//                             value == 'Bayar di Tempat'
//                                 ? Icons.money
//                                 : value == 'Transfer Bank'
//                                     ? Icons.account_balance
//                                     : value == 'QRIS'
//                                         ? Icons.qr_code
//                                         : Icons.account_balance_wallet,
//                             size: 20,
//                             color: AppTheme.primaryColor,
//                           ),
//                           const SizedBox(width: 12),
//                           Text(value),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),

//             // Add to Cart Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () => _addToCart(package),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                 ),
//                 child: const Text('TAMBAH KE KERANJANG'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
