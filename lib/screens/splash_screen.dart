import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:merit_app/dashboard/customDashboard.dart';
import 'package:merit_app/dashboard/dashboard.dart';
import 'package:merit_app/pages/Login/login.dart';
import 'package:merit_app/pages/Registration/registration.dart';
import 'package:merit_app/screens/home/main_Page.dart';
import 'package:page_transition/page_transition.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Clean Code',
        home: AnimatedSplashScreen(
            duration: 2000,
            splash:  'assets/merit.png',
            splashIconSize: 100,
            nextScreen: const Login(),
            splashTransition: SplashTransition.scaleTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Colors.white));
  }
}
