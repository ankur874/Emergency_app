import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/Model/roomModel.dart';
import 'package:emergency_app/Model/userModel.dart';
import 'package:emergency_app/Resources/Auth.dart';
import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Room_Screen.dart';
import 'package:emergency_app/Utils/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JoiningScreen extends StatefulWidget {
  @override
  _JoiningScreenState createState() => _JoiningScreenState();
}

class _JoiningScreenState extends State<JoiningScreen> {
  TextEditingController roomIdController = new TextEditingController();
  SharedPrefs _sharedPrefs = new SharedPrefs();
  Future<void> joinRoom() async {
    print("--------------------------------------------------");
    DocumentSnapshot<Map<String, dynamic>> vari = await FirebaseFirestore
        .instance
        .collection("rooms")
        .doc(roomIdController.text.toString())
        .get();

    roomModel room = roomModel.fromMap(vari.data()!);
    List<dynamic> newMates = vari["mates"];

    print("-----------------------------6464----------");
    User currentUser = await getCurrentUser();
    newMates.add(currentUser.uid);
    FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomIdController.text)
        .update({"mates": newMates});
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .update({"joinedRoom": room.rid}).then((value) {
      _sharedPrefs.saveUserRoom(true).whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => RoomScreen()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join a class"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
                  controller: roomIdController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: "Enter Room I'd",
                    hintStyle: TextStyle(fontSize: 16.0),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                )),
            SizedBox(height: 20.0),
            Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 40.0,
                child: ElevatedButton(
                    onPressed: () {
                      joinRoom();
                    },
                    child: Text("Join"))),
          ],
        ),
      ),
    );
  }
}
