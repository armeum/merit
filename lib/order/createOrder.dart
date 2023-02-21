import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: null,
        child: Icon(
          color: Colors.white,
          Icons.add,
        ),
      ),
    );
  }
}
