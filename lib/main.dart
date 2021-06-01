import 'package:emergency_app/Screens/Home_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Emergency App",
      home: HomeScreen(),
    );
  }
}
