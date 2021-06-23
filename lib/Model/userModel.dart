import 'package:flutter/cupertino.dart';

class userClass {
  String uid = "";
  String email = "";
  String joinedRoom = "";
  bool isAdmin = false;
  String tokenId = "";

  userClass(
      {required this.uid,
      required this.email,
      required this.joinedRoom,
      required this.isAdmin,
      required this.tokenId});

  Map<String, dynamic> toMap(userClass user) {
    Map<String, dynamic> data = {
      "uid": user.uid,
      "email": user.email,
      "joinedRoom": user.joinedRoom,
      "isAdmin": user.isAdmin,
      "tokenId": user.tokenId
    };
    return data;
  }

  userClass.fromMap(Map<String, dynamic> mapData) {
    this.email = mapData["email"];
    this.uid = mapData["uid"];
    this.joinedRoom = mapData["joinedRoom"];
    this.isAdmin = mapData["isAdmin"];
    this.tokenId = mapData["tokenId"];
  }
}
