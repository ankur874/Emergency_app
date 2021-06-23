import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/Model/roomModel.dart';
import 'package:emergency_app/Model/userModel.dart';
import 'package:emergency_app/Resources/Auth.dart';
import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool isLoading = false;
  late String userEmail = "";
  late String roomId;
  late bool isAdmin;
  String adminEmail = "";
  String roomName = "";
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
      roomName = room.roomName;
    });
  }

  leaveRoom() async {
    setState(() {
      isLoading = true;
    });
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
      } else {
        await FirebaseFirestore.instance
            .collection("rooms")
            .doc(roomId)
            .delete();
      }
    }
    sharedPrefs.removeRoomSettings().whenComplete(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              strokeWidth: 6,
              color: Color(0xffF54748),
            ),
          )
        : Scaffold(
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )),
                  ListView.builder(
                      itemCount: matesEmail.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.grey.shade100)
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
              backgroundColor: Color(0xff343F56),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.phoneSquareAlt,
                      size: 300,
                      color: Color(0xffF54748),
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
                                            Navigator.pop(context);
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
            ),
          );
  }
}
