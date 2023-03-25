import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merit_app/utils/dimensions.dart';
import 'package:merit_app/utils/url.dart';

class OrdersList extends StatefulWidget {
  final String currentUser;

  const OrdersList({super.key, required this.currentUser});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  var orderList = [];

  void fetchData() async {
    var response = await http.get(Uri.parse('$platformUrl/all_orders'));
    if (response.statusCode == 200) {
      List all = convert.jsonDecode(response.body);
      List filtered = [];
      for (Map<String, dynamic> order in all) {
        // Do something with currentMap
        if (order['userId'] == widget.currentUser) {
          filtered.add(order);
        }
      }
      setState(() {
        orderList = filtered;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1C6EAB),
        title: Text(
          "${widget.currentUser}",
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: orderList == []
            ? const CircularProgressIndicator(
                color: Colors.blue,
              )
            : ListView.builder(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                itemCount: orderList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                      bottom: 10,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff1C6EAB),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.shopping_cart,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight:
                                    Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "Midori: ${orderList[index]['amount']}kg",
                                      style: const TextStyle(fontSize: 20)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Zakaz kelish kuni: ${orderList[index]['deadline']}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Zakaz kuni: ${orderList[index]['orderedDate']}"
                                        .substring(0, 28),
                                    style: const TextStyle(fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class DynamicWidget extends StatelessWidget {
  const DynamicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter your username',
      ),
    );
  }
}
