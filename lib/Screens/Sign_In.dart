import 'package:emergency_app/Resources/Auth.dart';
import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Home_Screen.dart';
import 'package:emergency_app/Screens/Sign_Up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  final SharedPrefs sharedPrefs = SharedPrefs();
  signInUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential user = await signInWithEmail(_email.text, _password.text);
      if (user != null) {
        setState(() {
          isLoading = true;
        });
        sharedPrefs.saveUserSettings(true).whenComplete(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFB9300),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 6,
              backgroundColor: Colors.black,
              color: Color(0xffF54748),
            ))
          : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xffF5E6CA),
                          borderRadius: BorderRadius.circular(30)),
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              controller: _email,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blueGrey.shade300,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 18),
                                hintText: "Email",
                                hintStyle: TextStyle(fontSize: 16.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey.shade300),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: _password,
                                style: TextStyle(fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.blueGrey.shade300,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 18),
                                  hintText: "Password",
                                  hintStyle: TextStyle(fontSize: 16.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueGrey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueGrey.shade300),
                                  ),
                                ),
                              )),
                          SizedBox(height: 30),
                          Hero(
                            tag: "btn",
                            child: Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xffF54748)),
                                  onPressed: () {
                                    signInUser();
                                  },
                                  child: Text("Sign In")),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text("Create an account? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
