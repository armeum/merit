import 'package:flutter/material.dart';
import 'package:merit_app/utils/Token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/categories.dart';

class MainPage extends StatefulWidget {
  final String name;
  const MainPage({super.key, required this.name});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String text ='click me to see the token';
  String token = '';
  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
  }

  @override
  void initState() {
    super.initState();
    getToken();
    // Perform initialization tasks here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor,
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
            child: Categories(),
          ),
        )
      ],
    ));
  }
}
