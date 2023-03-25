import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merit_app/pages/admin/admin_categories.dart';
import 'package:merit_app/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPage extends StatefulWidget {
  final String name;
  const AdminPage({Key? key, required this.name}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String text = 'click me to see the token';
  String token = '';

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
  }

  final List<String> items = List<String>.generate(10000, (i) => '$i');
  var orderList = [];

  void fetchData() async {
    var response = await http.get(Uri.parse('$platformUrl/all_orders'));
    if (response.statusCode == 200) {
      setState(() {
        orderList = convert.jsonDecode(response.body);
      });
      print(orderList);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 45,
                bottom: 15,
              ),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Admin",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1C6EAB),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xff1C6EAB),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),

            const Expanded(
              child: SingleChildScrollView(
                child: AdminCategories(),
              ),
            )
          ],
        ));
  }
}
