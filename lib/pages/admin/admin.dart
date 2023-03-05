import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merit_app/utils/url.dart';
import 'dart:convert' as convert;

class adminPage extends StatefulWidget {
  const adminPage({Key? key}) : super(key: key);
  @override
  State<adminPage> createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {
  final List<String> items = List<String>.generate(10000, (i) => '$i');
  var orderList = [];

  void fetchData() async {
    var response = await http.get(Uri.parse('$platformUrl/all_orders'));
    if (response.statusCode == 200) {
      setState(() {
        orderList = convert.jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    print(orderList);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Admin page",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body:ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xffc9070e),
              child: Text(items[index]),
            ),
            title: Text('Item ${items[index]}'),
            subtitle: Text('Item description'),
            trailing: Icon(Icons.more_vert),
          );
        },

      ),
    );
  }
}
