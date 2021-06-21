import 'package:emergency_app/Resources/Auth.dart';
import 'package:emergency_app/Resources/shared_prefs.dart';
import 'package:emergency_app/Screens/Home_Screen.dart';
import 'package:emergency_app/Screens/Sign_In.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();
    final SharedPrefs sharedPrefs = SharedPrefs();
     SignUpUser() async {
      print(_emailController.text);
      print(_passwordController.text);
      try {
        UserCredential signedUpUser = await signupWithEmail(
            _emailController.text, _passwordController.text);
        if (signedUpUser != null) {
          uploadToDb(signedUpUser.user!).then((value) {
            sharedPrefs.saveUserSettings(true).whenComplete((){
                    Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
            });
           
          });
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFormField(
                      controller: _emailController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.shade300,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                        hintText: "Email",
                        hintStyle: TextStyle(fontSize: 16.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey.shade300),
                            borderRadius: BorderRadius.circular(20.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey.shade300),
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextFormField(
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
                              borderSide:
                                  BorderSide(color: Colors.blueGrey.shade300),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey.shade300),
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      )),
                  SizedBox(height: 30),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade400),
                        onPressed: () {
                          SignUpUser();
                        },
                        child: Text("Sign Up")),
                  ),
                  SizedBox(height: 20),
                  Row(
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
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
