// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
   _navigateToHome();

  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/AuthCheck');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0B0A4C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         Lottie.asset('assets/notes.json'),
        ],),
      ),
    );
  }
}