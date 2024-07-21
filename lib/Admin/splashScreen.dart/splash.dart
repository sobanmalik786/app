import 'dart:async';
import 'package:app/Admin/splashScreen.dart/splash1.dart'; // Replace with your correct import path
import 'package:app/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const LoginScreen(), // Replace with your next screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false; // Prevents back navigation
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/splash.PNG', // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
            const Center(),
          ],
        ),
      ),
    );
  }
}
