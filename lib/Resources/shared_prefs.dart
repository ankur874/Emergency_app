import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future saveUserSettings(
    bool isLoggedIn,
    String userEmail,
    String userPass,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLoggedIn", isLoggedIn);
    sharedPreferences.setString("userEmail", userEmail);
    sharedPreferences.setString("userPass", userPass);
  }

  Future saveUserRoom(bool isJoinedRoom) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isJoinedRoom", isJoinedRoom);
  }

  Future getUserState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("isLoggedIn");
  }

  Future getUserRoom() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("isJoinedRoom");
  }

  Future getUserEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("userEmail");
  }

  Future getUserPass() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("userPass");
  }

  Future removeUserSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("isLoggedIn");
    sharedPreferences.remove("userEmail");
    sharedPreferences.remove("userPass");
    sharedPreferences.remove("isJoinedRoom");
  }
}
