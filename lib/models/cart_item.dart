import 'package:flutter/material.dart';

class CartItem {
  final String packageType;
  final double price;
  final DateTime scheduledDate;
  final TimeOfDay startTime;
  final String paymentMethod;

  CartItem({
    required this.packageType,
    required this.price,
    required this.scheduledDate,
    required this.startTime,
    required this.paymentMethod,
  });
}
