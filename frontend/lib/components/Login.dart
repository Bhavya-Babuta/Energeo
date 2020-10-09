import 'package:frontend/components/AQI/SelectDevice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import "package:flutter/animation.dart";
import 'dart:async';

class Login extends StatefulWidget {
  @override
  _State createState() => _State();
}

final storage = FlutterSecureStorage();

Future<String> attemptLogIn(String username, String password) async {
  var res = await http.post("https://dashboard.airveda.com/api/token/",
      body: {"email": username, "password": password});
  if (res.statusCode == 200) {
    final decoded = json.decode(res.body);
    await storage.write(key: "jwt", value: decoded["idToken"]);
    await storage.write(key: "refreshToken", value: decoded["refreshToken"]);
    return decoded["idToken"];
  }
  return null;
}

void displayDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(title: Text(title), content: Text(text)),
    );

class _State extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double _loginOffsetY = 9999;
  double windowHeight = 0;
  double windowWidth = 0;
  int pageState = 0;
  double _loginContainerOffsetY = 0;
  bool showPassword = false;
  double loginContainerHeight = 250;
  var _emailfocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();

  void elementHasFocus(hasFocus) {
    hasFocus
        ? setState(() {
            loginContainerHeight = 170;
            _loginOffsetY = 215;
          })
        : setState(() {
            loginContainerHeight = 250;
            _loginOffsetY = 300;
          });
  }

  @override
  void initState() {
    super.initState();
    _emailfocusNode.addListener(() {
      elementHasFocus(_emailfocusNode.hasFocus);
    });
    _passwordFocusNode.addListener(() {
      elementHasFocus(_passwordFocusNode.hasFocus);
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_loginContainerOffsetY != 10) {
        setState(() {
          _loginContainerOffsetY = 10;
        });
      }
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_loginOffsetY != 300) {
        setState(() {
          _loginOffsetY = 300;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                transform:
                    Matrix4.translationValues(0, _loginContainerOffsetY, 1),
                duration: Duration(milliseconds: 1000),
                child: Stack(children: [
                  AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          margin: const EdgeInsets.only(top: 40),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/logo/logo-with-name.png'),
                          )),
                          height: loginContainerHeight)),
                  AnimatedContainer(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.green[50],
                              Colors.green[100],
                              Colors.green[200],
                              Colors.green[300],
                              Colors.green[500]
                            ],
                            tileMode: TileMode.repeated,
                          ),
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      transform: Matrix4.translationValues(0, _loginOffsetY, 1),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            child: TextField(
                                focusNode: _emailfocusNode,
                                controller: nameController,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person, color: Colors.green),
                                  labelText: "Your Email",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: TextField(
                              focusNode: _passwordFocusNode,
                              obscureText: !showPassword,
                              controller: passwordController,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.green),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                        showPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.green),
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    }),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                labelText: "Password",
                              ),
                            ),
                          ),
                          Container(
                              height: 50,
                              margin:
                                  EdgeInsets.only(top: 25, right: 20, left: 20),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                textColor: Colors.white,
                                color: Colors.green,
                                child: Text('Login'),
                                onPressed: () async {
                                  var username = nameController.text;
                                  var password = passwordController.text;
                                  var jwt =
                                      await attemptLogIn(username, password);
                                  if (jwt != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectDevice()));
                                  } else {
                                    displayDialog(context, "An Error Occurred",
                                        "No account was found matching that username and password");
                                  }
                                },
                              )),
                        ],
                      ))
                ]))));
  }
}
