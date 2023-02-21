import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  final List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text(products[index].code),
            trailing: Text(products[index].price.toString()),
          );
        },
      ),
    );
  }
}
