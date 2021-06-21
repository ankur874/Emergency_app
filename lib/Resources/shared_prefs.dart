import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future saveUserSettings(
    bool isLoggedIn,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLoggedIn", isLoggedIn);
  }

  Future saveUserRoom(bool isJoinedRoom) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isJoinedRoom", isJoinedRoom);
  }

  Future getUserState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("isLoggedIn");
  }

  Future removeRoomSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("isJoinedRoom");
  }

  Future getUserRoom() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("isJoinedRoom");
  }

  Future removeUserSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("isLoggedIn");
    sharedPreferences.remove("userEmail");
    sharedPreferences.remove("userPass");
  }
}
