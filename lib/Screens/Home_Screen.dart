import 'package:emergency_app/Resources/Auth.dart';
import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Create_Room.dart';
import 'package:emergency_app/Screens/Joining_Screen.dart';
import 'package:emergency_app/Screens/Sign_In.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SharedPrefs sharedPrefs = SharedPrefs();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                signOut();
                await sharedPrefs.removeUserSettings().whenComplete(() {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                });
              },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: Color(0xff343F56),
        centerTitle: true,
        title: Text(
          "Emergency",
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xffFB9300)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoiningScreen()));
                  },
                  child: Text(
                    "Join a class",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xffF54748)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateRoom()));
                  },
                  child: Text(
                    "Create a class",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
