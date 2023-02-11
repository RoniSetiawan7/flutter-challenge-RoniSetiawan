import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_challenge_ronisetiawan/dashboard/dashboard.dart';
import 'package:flutter_challenge_ronisetiawan/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> timer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('userToken');

    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (token != null && token.isNotEmpty) {
              return const DashboardScreen();
            } else {
              return const LoginScreen();
            }
          },
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
