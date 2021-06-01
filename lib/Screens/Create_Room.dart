import 'package:emergency_app/Screens/Room_Screen.dart';
import 'package:flutter/material.dart';

class CreateRoom extends StatefulWidget {
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Room"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
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
              Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 40.0,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RoomScreen()));
                      },
                      child: Text("Create Room"))),
            ],
          ),
        ));
  }
}
