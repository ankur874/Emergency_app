import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/Model/roomModel.dart';
import 'package:emergency_app/Model/userModel.dart';
import 'package:emergency_app/Resources/Auth.dart';
import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Room_Screen.dart';
import 'package:emergency_app/Utils/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JoiningScreen extends StatefulWidget {
  @override
  _JoiningScreenState createState() => _JoiningScreenState();
}

class _JoiningScreenState extends State<JoiningScreen> {
  TextEditingController roomIdController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  final SharedPrefs _sharedPrefs = SharedPrefs();
  bool isLoading = false;
  Future<void> joinRoom() async {
    try {
      print("--------------------------------------------------");
      DocumentSnapshot<Map<String, dynamic>> vari = await FirebaseFirestore
          .instance
          .collection("rooms")
          .doc(roomIdController.text.toString())
          .get();
      if (vari == null) {
        Fluttertoast.showToast(msg: "No room exist!");
      } else {
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
                context, MaterialPageRoute(builder: (context) => RoomScreen()));
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join a class"),
        backgroundColor: Color(0xff343F56),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    validator: (val) {
                      return val!.length == 0
                          ? "Room I'd can't be empty"
                          : null;
                    },
                    controller: roomIdController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: "Enter Room I'd",
                      hintStyle: TextStyle(fontSize: 16.0),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  )),
            ),
            SizedBox(height: 20.0),
            Hero(
              tag: "joinRoom",
              child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 40.0,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xffFB9300)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) joinRoom();
                      },
                      child: Text("Join"))),
            ),
          ],
        ),
      ),
    );
  }
}
