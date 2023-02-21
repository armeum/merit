import 'package:flutter/material.dart';
import '../../widgets/productsList.dart';
import '../../widgets/categories.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: Container(
            margin: const EdgeInsets.only(
              top: 45,
              bottom: 15,
            ),
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Asr Kimya',
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
                      child: Icon(
                        Icons.search,
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Categories(),
          ),
        )
      ],
    ));
  }
}