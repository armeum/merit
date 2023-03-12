import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merit_app/dashboard/customDashboard.dart';
import 'package:merit_app/pages/Registration/registration.dart';
import 'package:merit_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Asr Kim-ya",
      theme: ThemeData(
        primaryColor: const Color(0xff1C6EAB),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color.fromARGB(255, 255, 255, 255)),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff1C6EAB),
          ),
          titleLarge: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(255, 89, 88, 88),
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      home:  SplashScreen(),
    );
  }
}

//ggghh
