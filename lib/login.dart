import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // variable for saving data from data json which derive from php code in the file login.php
  String username, password;

  String alert = "Ready for Login";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();

  // method for login process
  void loginProcess() async {
    if (_formKey.currentState.validate()) {
      // 10.0.2.2 is ip address from android studio's emulator

      final response = await http
          .post("http://192.168.42.198/tokoku_db/login.php", body: {
        "username": usernameInput.text,
        "password": passwordInput.text
      });

      var dataUser = json.decode(response.body);

      if (dataUser.length < 1) {
        // if data user is empty or 0
        setState(() {
          alert = "You can't login";
        });
      } else {
        setState(() {
          username = dataUser[0]["username"];
          password = dataUser[0]["password"];
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        color: Colors.lightBlue,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.black87, shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Welcome...",
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  alert,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: usernameInput,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87)),
                          prefixIcon: Icon(
                            Icons.mail,
                            size: 40,
                          ),
                          hintText: "Enter your username",
                          hintStyle: TextStyle(color: Colors.black87),
                          labelText: "Username",
                          labelStyle: TextStyle(color: Colors.black87),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Username is empty";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordInput,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87)),
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 40,
                          ),
                          hintText: "Enter your password",
                          hintStyle: TextStyle(color: Colors.black87),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black87),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Password is empty";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: Colors.black87,
                        elevation: 5,
                        child: Container(
                          height: 50,
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              loginProcess();
                            },
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
