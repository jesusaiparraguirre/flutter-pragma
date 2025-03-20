import 'package:flutter/material.dart';
import 'package:pragma_test/utils/constants/constants.dart';
import 'package:pragma_test/utils/extensions/color_extension.dart';
import 'package:pragma_test/ui/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Pragma',
      theme: ThemeData(
        fontFamily: ROBOTO_REGULAR,
        primarySwatch: AppColor.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: SplashScreen(),
    );
  }
}