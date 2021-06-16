import 'package:flutter/cupertino.dart';

class userClass {
   String uid="";
   String email="";
  String joinedRoom="";
  bool isAdmin=false;

  userClass(
      {required this.uid,
      required this.email,
      required this.joinedRoom,
      required this.isAdmin});

  Map<String,dynamic> toMap(userClass user) {
    Map<String, dynamic> data={"uid":user.uid,"email":user.email,"joinedRoom":user.joinedRoom,"isAdmin":user.isAdmin};
    return data;
  }

  userClass.fromMap(Map<String, dynamic> mapData) {
    this.email = mapData["email"];
    this.uid = mapData["uid"];
    this.joinedRoom = mapData["joinedRoom"];
    this.isAdmin = mapData["isAdmin"];
  }
}
