import 'package:emergency_app/Screens/Splash_Screen.dart';
import 'package:flutter/material.dart';

const String splash = "/splash";
const kAppId = "bf5e478b-3714-49c0-aae4-137dc3e6e308";
final routes = {splash: (context) => SplashScreen()};
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
