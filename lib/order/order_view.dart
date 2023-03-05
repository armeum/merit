import 'package:flutter/material.dart';
import '../../models/product.dart';

class OrderView extends StatelessWidget {
  OrderView({super.key});

  final List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Column(
        children: [],
      )
    );
  }
}
