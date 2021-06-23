import 'package:emergency_app/Resources/Auth.dart';
import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Home_Screen.dart';
import 'package:emergency_app/Screens/Sign_In.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();
    TextEditingController _confirmPassController = new TextEditingController();
    final SharedPrefs sharedPrefs = SharedPrefs();
    SignUpUser() async {
      setState(() {
        isLoading = true;
      });
      try {
        UserCredential signedUpUser = await signupWithEmail(
            _emailController.text, _passwordController.text);
        if (signedUpUser != null) {
          setState(() {
            isLoading = true;
          });
          uploadToDb(signedUpUser.user!).then((value) {
            sharedPrefs.saveUserSettings(true).whenComplete(() {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            });
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

    return Scaffold(
      backgroundColor: Color(0xffFB9300),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                strokeWidth: 6,
                color: Color(0xffF54748),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  Hero(
                    tag: "logo",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logo.gif",
                          scale: 12,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(blurRadius: 10)],
                          color: Color(0xffF5E6CA),
                          borderRadius: BorderRadius.circular(30)),
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: TextFormField(
                                validator: (value) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value!)
                                      ? null
                                      : "Enter valid email address";
                                },
                                controller: _emailController,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0),
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
                                  validator: (val) {
                                    return val!.length <= 6 && val.length >= 15
                                        ? "Password length should be between 6 and 15"
                                        : null;
                                  },
                                  textAlign: TextAlign.center,
                                  controller: _passwordController,
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
                            Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: TextFormField(
                                  validator: (val) {
                                    if (_passwordController.text !=
                                        _confirmPassController.text) {
                                      return "Password does not match";
                                    }
                                  },
                                  textAlign: TextAlign.center,
                                  controller: _confirmPassController,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.blueGrey.shade300,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 18),
                                    hintText: "Confirm Password",
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
                                      if (formKey.currentState!.validate()) {
                                        SignUpUser();
                                      }
                                    },
                                    child: Text("Sign Up")),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already registered? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignIn()));
                                  },
                                  child: Text(
                                    "Sign In",
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
                  ),
                ],
              ),
            ),
    );
  }
}
