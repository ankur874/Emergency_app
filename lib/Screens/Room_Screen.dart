import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/Model/roomModel.dart';
import 'package:emergency_app/Model/userModel.dart';
import 'package:emergency_app/Resources/Auth.dart';
import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool isLoading = true;
  late String userEmail = "";
  late String roomId;
  late bool isAdmin;
  String adminEmail = "";
  late String roomName = "rooms";
  List<dynamic> mates = [];
  List<String> matesEmail = [];
  late roomModel realRoom;
  final SharedPrefs sharedPrefs = SharedPrefs();
  getUserDetails() async {
    User joinedUser = await getCurrentUser();
    String joinedUserId = joinedUser.uid;

    DocumentSnapshot<Map<String, dynamic>> userMap = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(joinedUserId)
        .get();
    userClass _user = userClass.fromMap(userMap.data()!);
    setState(() {
      userEmail = _user.email;
      roomId = _user.joinedRoom;
      isAdmin = _user.isAdmin;
      isLoading = false;
    });
    DocumentSnapshot<Map<String, dynamic>> myRoom =
        await FirebaseFirestore.instance.collection("rooms").doc(roomId).get();
    roomModel room = roomModel.fromMap(myRoom.data()!);
    String adminId = room.adminId;

    realRoom = room;
    mates = room.mates;
    for (int i = 0; i < mates.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(mates[i])
          .get();
      matesEmail.add(data.data()!["email"]);
    }
    DocumentSnapshot<Map<String, dynamic>> su =
        await FirebaseFirestore.instance.collection("users").doc(adminId).get();
    userClass user = userClass.fromMap(su.data()!);
    this.setState(() {
      adminEmail = user.email;
    });
  }

  leaveRoom() async {
    User joinedUser = await getCurrentUser();
    String joinedUserId = joinedUser.uid;
    if (!isAdmin) {
      for (int i = 0; i < mates.length; i++) {
        if (mates[i] == joinedUserId) {
          mates.removeAt(i);
          break;
        }
      }
      await FirebaseFirestore.instance
          .collection("rooms")
          .doc(roomId)
          .update({"mates": mates});
      await FirebaseFirestore.instance
          .collection("users")
          .doc(joinedUserId)
          .update({"joinedRoom": "", "isAdmin": false});
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(joinedUserId)
          .update({"joinedRoom": "", "isAdmin": false});
      late String newAdmin;
      if (mates.length >= 1) {
        newAdmin = mates[0];
        mates.removeAt(0);
        await FirebaseFirestore.instance
            .collection("rooms")
            .doc(roomId)
            .update({"adminId": newAdmin, "mates": mates});
        await FirebaseFirestore.instance
            .collection("users")
            .doc(newAdmin)
            .update({"isAdmin": true});
      } else {}
    }
    sharedPrefs.removeRoomSettings().whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.red.shade500),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Admin"),
                  Text(adminEmail),
                ],
              )),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Room Participants",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )),
            ListView.builder(
                itemCount: matesEmail.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(blurRadius: 2, color: Colors.grey.shade100)
                      ]),
                      child: ListTile(
                        title: Text(matesEmail[index]),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(roomName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.red,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 50.0)],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                  child: Text(
                "CALL",
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
            ),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 1,
                              sigmaY: 1,
                              tileMode: TileMode.repeated),
                          child: AlertDialog(
                            
                            title: Text("Leave!"),
                            content: Text(
                                "Are you sure you want to leave this room?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    leaveRoom();
                                  },
                                  child: Text("Yes")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No")),
                            ],
                          ),
                        );
                      });
                },
                child: Text("Leave Room")),
            Text(userEmail),
          ],
        ),
      ),
    );
  }
}
