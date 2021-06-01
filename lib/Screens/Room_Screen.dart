import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
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
          ],
        ),
      ),
    );
  }
}
