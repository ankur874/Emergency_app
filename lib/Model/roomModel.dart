import 'package:emergency_app/Model/userModel.dart';

class roomModel {
  String rid = "";
  String adminId = "";
  String roomName = "";
  List<dynamic> mates = [];

  roomModel({required this.rid,required this.adminId, required this.mates,required this.roomName});

  Map<String, dynamic> toMap(roomModel room) {
    Map<String, dynamic> myMap = {
      "rid": room.rid,
      "adminId": room.adminId,
      "mates": room.mates,
      "roomName":room.roomName,
    };
    return myMap;
  }

  roomModel.fromMap(Map<String, dynamic> myMap) {
    this.adminId = myMap["adminId"];
    this.mates = myMap["mates"];
    this.rid = myMap["rid"];
    this.roomName=myMap["roomName"];
  }
}
