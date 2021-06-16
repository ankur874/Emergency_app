import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/Resources/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  final roomdetails;
  final isAdmin;
  RoomScreen({this.roomdetails,this.isAdmin});
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
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
            ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Ankur"),
                  );
                }),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Room"),
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
                "SHAKE",
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
            ),
            SizedBox(height: 50),
            widget.isAdmin == true
                ? ElevatedButton(onPressed: () {
                  //FirebaseFirestore.instance.collection("rooms").doc()
                }, child: Text("Delete Room"))
                : ElevatedButton(onPressed: () {}, child: Text("Leave Room")),
          ],
        ),
      ),
    );
  }
}
