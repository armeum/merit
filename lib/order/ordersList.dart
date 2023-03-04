import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:merit_app/models/order.dart';
import 'package:merit_app/utils/dimensions.dart';
import 'package:http/http.dart' as http;
import 'package:merit_app/utils/url.dart';

import '../screens/Album.dart';

class OrdersList extends StatefulWidget {
  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  var orderList = [];

  String texttt = '';

  void FetchData() async {
    var response = await http.get(Uri.parse('$platformUrl/all_orders'));
    if (response.statusCode == 200) {
      setState(() {
        orderList = convert.jsonDecode(response.body);
      });
      print(orderList);
    } else {
      print(orderList);
      setState(() {
        // orderList = [];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () => setState(() {}), child: Text("press me")),
          TextButton(onPressed: () => setState(() {}), child: Text("Me also")),
        ],
      ),
      body: Container(
          color: Colors.white,
            child: orderList == []
                ? const CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : ListView.builder(
              padding: EdgeInsets.only(top: 20, bottom: 10),
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
                                color: Theme.of(context).primaryColor,
                              ),
                              child: const Center(
                                child: const Icon(
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
                                    topRight:
                                        Radius.circular(Dimensions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        orderList[index]['amount'].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        orderList[index]['deadline'].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
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
