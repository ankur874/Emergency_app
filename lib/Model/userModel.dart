class userClass {
   late String uid;
   late String email;
   late String joinedRoom;
   late bool isAdmin;

  userClass(this.uid, this.email, this.joinedRoom, this.isAdmin);

  Map toMap(userClass user) {
    var data = Map<dynamic, dynamic>();
    data["uid"] = user.uid;
    data["email"] = user.email;
    data["joinedRoom"] = user.joinedRoom;
    data["isAdmin"] = user.isAdmin;
    return data;
  }

  userClass.fromMap(Map<dynamic, dynamic> mapData) {
    this.email = mapData["email"];
    this.uid = mapData["uid"];
    this.joinedRoom = mapData["joinedRoom"];
    this.isAdmin = mapData["eisAdminmail"];
  }
}
