import 'dart:async';

import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Home_Screen.dart';
import 'package:emergency_app/Screens/Sign_In.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPrefs _sharedPrefs = SharedPrefs();
  @override
  void initState() {
    _sharedPrefs.getUserState().then((value) {
      if (value != null) {
       
             Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignIn()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Icon(Icons.zoom_out),),
    );
  }
}
