import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Home_Screen.dart';
import 'package:emergency_app/Screens/Room_Screen.dart';
import 'package:emergency_app/Screens/Sign_In.dart';
import 'package:emergency_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPrefs _sharedPrefs = SharedPrefs();

  bool isLoading = true;
  @override
  void initState() {
    _sharedPrefs.getUserState().then((value) async {
      if (value != null) {
        _sharedPrefs.getUserRoom().then((event) {
          if (event != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => RoomScreen()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        });
      } else {
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
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.red,
              backgroundColor: Colors.black,
              strokeWidth: 6,
            )
          : Container(),
    ));
  }
}
