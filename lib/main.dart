import 'package:flutter/material.dart';
import 'package:merit_app/pages/Login/login.dart';
import 'package:merit_app/pages/Registration/registeration.dart';
import 'package:merit_app/screens/client/createClient.dart';
import './screens/home/mainPage.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Asr Kimya",
      theme: ThemeData(
        primaryColor: Color(0xff1C6EAB),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff1C6EAB),
          ),
          headline6: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(255, 89, 88, 88),
          ),
          bodyText2: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(255, 255, 255, 255),
          ),

        ),
      ),
      home: const Login(),
    );
  }
}
