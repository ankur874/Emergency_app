import 'package:emergency_app/Screens/Splash_Screen.dart';
import 'package:flutter/material.dart';

const String splash = "/splash";
final routes = {splash:(context)=>SplashScreen()};
Widget formField(String hintText) {
  return TextFormField(
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(8.0),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 16.0),
      enabledBorder: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(),
    ),
  );
}
