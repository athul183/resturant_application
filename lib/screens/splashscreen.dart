import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_application/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    splashscreenmethod();
    super.initState();
  }

  void splashscreenmethod(){
    Timer(const Duration(seconds: 3), () {

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LoginPage())
      );
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/logo/tasklogo.png"),
      ),
    );
  }
}