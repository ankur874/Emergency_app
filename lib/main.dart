import 'package:emergency_app/Screens/Home_Screen.dart';
import 'package:emergency_app/Screens/Sign_Up.dart';
import 'package:emergency_app/Screens/Splash_Screen.dart';
import 'package:emergency_app/Utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(primaryColor: Color(0xffFB9300)),
      title: "Emergency App",
      home: SplashScreen(),
    );
  }
}
