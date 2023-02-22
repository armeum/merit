import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:merit_app/order/ordersList.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  String message = "";
  var amountController = '';
  var dateController = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Create Order"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                onChanged: (value) => {
                  dateController = value,
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Date",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,

                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String? formattedDate =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      dateController =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) => {
                  amountController = value,
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.scale),
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {
                  if (amountController.isEmpty || dateController.isEmpty) {
                    setState(() {
                      message = "Please fill all the fields";
                    });
                    print("tanlang");
                  } else {
                    Future<http.Response> createOrder() async {
                      final response = await http.post(
                          Uri.parse('http://127.0.0.1:8000/create_order'),
                          headers: <String, String>{
                            'Accept': 'application/json',
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'amount': amountController,
                            'date': dateController,
                          }));

                      print(response.body);
                      if (response.statusCode == 200) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrdersList(),
                          ),
                        );
                      }
                      return response;
                    }

                    createOrder();
                  }
                },
                child: Text(
                  'Order',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
