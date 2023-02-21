import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String code;
  final double price;
  final double quantity;
  bool isPopular;

  Product({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.quantity,
    this.isPopular = false,
  });
}
