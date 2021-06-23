import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/Model/roomModel.dart';
import 'package:emergency_app/Resources/Auth.dart';
import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Room_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';

class CreateRoom extends StatefulWidget {
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  bool isLoading = false;
  TextEditingController roomNameController = new TextEditingController();
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final SharedPrefs sharedPrefs = SharedPrefs();
  changeUserDetails(roomModel newRoom) async {
    User currentUser = await getCurrentUser();
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId)
        .update({"isAdmin": true, "joinedRoom": newRoom.rid});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Room"),
          backgroundColor: Color(0xff343F56),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  strokeWidth: 6,
                  color: Color(0xffF54748),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        controller: roomNameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          hintText: "Enter Room Name",
                          hintStyle: TextStyle(fontSize: 16.0),
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Hero(
                      tag: "createRoom",
                      child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 40.0,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffF54748)),
                              onPressed: () {
                                var id = customAlphabet(
                                    roomNameController.text + "123456789", 10);

                                roomModel newRoom = new roomModel(
                                    rid: id.toString(),
                                    adminId: currentUserId,
                                    mates: [],
                                    roomName: roomNameController.text);
                                uploadRoomToDb(newRoom);
                                changeUserDetails(newRoom);
                                sharedPrefs.saveUserRoom(true).whenComplete(() {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RoomScreen()),
                                      (route) => false);
                                });
                              },
                              child: Text("Create Room"))),
                    ),
                  ],
                ),
              ));
  }
}
