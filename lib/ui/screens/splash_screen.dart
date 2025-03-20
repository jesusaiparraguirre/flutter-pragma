import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pragma_test/ui/screens/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadSplash();
  }

  Future<Timer> loadSplash() async {
    return Timer(
      const Duration(seconds: 3),
      onDoneLoading,
    );
  }

  onDoneLoading() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: ((context) => const LandingScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Catbreeds', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Lottie.asset(
              'assets/animations/cat.json',
              width: size.width,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}