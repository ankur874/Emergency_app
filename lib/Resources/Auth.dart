import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/Model/roomModel.dart';
import 'package:emergency_app/Model/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
Future<UserCredential> signupWithEmail(String email, String password) async {
  late UserCredential user;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user = userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == "weak-password") {
      Fluttertoast.showToast(msg: "Entered password is too weak!");
    } else if (e.code == "email-already-in-use") {
      Fluttertoast.showToast(msg: "Email already exists!");
    }
  } catch (e) {
    print(e);
  }
  return user;
}

Future<UserCredential> signInWithEmail(String email, String password) async {
  late UserCredential user;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    user = userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      Fluttertoast.showToast(msg: "User not found!");
    } else if (e.code == "wrong-password") {
      Fluttertoast.showToast(msg: "Wrong password!");
    }
  } catch (e) {
    print(e);
  }
  return user;
}

Future<User> getCurrentUser() async {
  User currentUser;
  currentUser = firebaseAuth.currentUser!;
  return currentUser;
}

Future<void> uploadToDb(User currentUser) async {
  var status = await OneSignal.shared.getDeviceState();
  String ?tokenId = status!.userId;
  userClass userclass = userClass(
      tokenId:tokenId! ,
      uid: currentUser.uid,
      email: currentUser.email!,
      joinedRoom: "",
      isAdmin: false);
  Map<String, dynamic> data = userclass.toMap(userclass);
  FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set(data);
}

Future<void> uploadRoomToDb(roomModel room) async {
  roomModel room1 = roomModel(
      rid: room.rid,
      adminId: room.adminId,
      mates: room.mates,
      roomName: room.roomName);
  Map<String, dynamic> data = room.toMap(room);
  FirebaseFirestore.instance.collection("rooms").doc(room.rid).set(data);
}

Future<void> signOut() async {
  await firebaseAuth.signOut();
}
