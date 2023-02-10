import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_challenge_ronisetiawan/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void timer() {
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset('assets/images/header-splash.png'),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset('assets/images/logo.png'),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset('assets/images/footer-splash.png'),
          ),
        ],
      ),
    );
  }
}
