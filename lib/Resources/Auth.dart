import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
Future<UserCredential> signupWithEmail(String email, String password) async {
  late UserCredential user;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user = userCredential;
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
  } catch (e) {
    print(e);
  }
  return user;
}

Future<User> getCurrentUser() async {
  late User currentUser;
  currentUser = firebaseAuth.currentUser!;
  return currentUser;
}
