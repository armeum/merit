import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';

class OrdersList extends StatefulWidget {
  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  List<DynamicWidget> listDynamic = [];

  addDynamic() {
    listDynamic.add(DynamicWidget());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            child: Flexible(
      child: ListView.builder(
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    )));
  }
}

class DynamicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter your username',
        ),
      ),
    );
  }
}
