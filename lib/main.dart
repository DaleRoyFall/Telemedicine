import 'package:flutter/material.dart';
import 'package:telemedicine/splash.dart';

void main() => runApp(MedicineApp());

class MedicineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}