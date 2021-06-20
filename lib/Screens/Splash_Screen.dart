import 'dart:async';

import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Home_Screen.dart';
import 'package:emergency_app/Screens/Room_Screen.dart';
import 'package:emergency_app/Screens/Sign_In.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPrefs _sharedPrefs = SharedPrefs();
  bool isLoading = true;
  @override
  void initState() {
    _sharedPrefs.getUserRoom().then((value)async {
      if (value != null) {
        this.setState(() {
          isLoading = false;
        });
        
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RoomScreen()));
      } else {
        this.setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: isLoading ? CircularProgressIndicator() : Container(),
    ));
  }
}
