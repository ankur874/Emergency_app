import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/Model/roomModel.dart';
import 'package:emergency_app/Model/userModel.dart';
import 'package:emergency_app/Resources/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool isLoading = true;
  late String userEmail;
  late String roomId;
  late bool isAdmin =false;
  String roomName = "rooms";
  List<dynamic> mates = [];
  List<String> matesEmail = [];
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
  }

  @override
  void initState() {
    super.initState();
    getUserDetails().whenComplete((){setState(() {
      
    });});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Expanded(
                  child: DrawerHeader(
                    curve: Curves.easeIn,
                    decoration: BoxDecoration(color: Colors.red),
                    child: Text("Room Participants"),
                  ),
                ),
              ],
            ),
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
            isAdmin == true
                ? ElevatedButton(
                    onPressed: () {
                      //deleteRoom();
                    },
                    child: Text("Delete Room"))
                : ElevatedButton(onPressed: () {}, child: Text("Leave Room")),
            Text(userEmail),
          ],
        ),
      ),
    );
  }
}
