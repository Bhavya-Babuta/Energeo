import 'package:frontend/JWT/token.dart';
import 'package:frontend/components/AQI/HomePage.dart';
import 'package:frontend/components/Loader.dart';
import 'package:frontend/components/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SelectDevice extends StatefulWidget {
  @override
  _SelectDevice createState() => _SelectDevice();
}

class _SelectDevice extends State<SelectDevice> {
  var devices = [];
  var loading = true;

  Future<List> _getDevices() async {
    final authToken = await Token().getToken();
    return await http.get("https://dashboard.airveda.com/api/data/devices/",
        headers: {
          "Authorization": "Bearer $authToken"
        }).then((value) =>
        value.statusCode == 200 ? json.decode(value.body)["data"] : null);
  }

  @override
  void initState() {
    super.initState();
    _getDevices().then((value) => setState(() {
          devices = value;
          loading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme:
            ThemeData(brightness: Brightness.dark, primarySwatch: Colors.green),
        home: Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: Icon(FlutterIcons.logout_ant),
                      onPressed: () async {
                        await Token().removeTokens();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Login()),
                            (r) => false);
                      },
                    ))
              ],
              title: Image.asset(
                'assets/logo/logo.png',
                width: 150,
                fit: BoxFit.cover,
              ),
              centerTitle: true,
            ),
            body: loading && devices.length == 0
                ? Loader()
                : AnimationLimiter(
                    child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(devices.length, (index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                      child: Container(
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.green,
                                                  blurRadius: 10.0,
                                                )
                                              ],
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.green[300],
                                                  Colors.green[500]
                                                ],
                                                tileMode: TileMode.repeated,
                                              ),
                                              color: Colors.greenAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          child: FlatButton(
                                              onPressed: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              devices[index]))),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: Table(
                                                          columnWidths: {
                                                            0: FlexColumnWidth(
                                                                0.85)
                                                          },
                                                          children: [
                                                            TableRow(children: [
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              3.0),
                                                                  child: Text(
                                                                      'Id: ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              13))),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            3.0),
                                                                child: Text(
                                                                    devices[index]["deviceId"] !=
                                                                            null
                                                                        ? devices[index]
                                                                            [
                                                                            "deviceId"]
                                                                        : "NA",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            13)),
                                                              )
                                                            ]),
                                                            TableRow(children: [
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              3.0),
                                                                  child: Text(
                                                                      'Name: ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              13))),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            3.0),
                                                                child: Text(
                                                                    devices[index]["name"] !=
                                                                            null
                                                                        ? devices[index]
                                                                            [
                                                                            "name"]
                                                                        : "NA",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            13)),
                                                              )
                                                            ]),
                                                            TableRow(children: [
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              3.0),
                                                                  child: Text(
                                                                      'Floor: ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              13))),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            3.0),
                                                                child: Text(
                                                                    devices[index]["floor"] !=
                                                                            null
                                                                        ? devices[index]
                                                                            [
                                                                            "floor"]
                                                                        : "NA",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            13)),
                                                              )
                                                            ]),
                                                            TableRow(children: [
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              3.0),
                                                                  child: Text(
                                                                      'Location: ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              13))),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            3.0),
                                                                child: Text(
                                                                    devices[index]["locationName"] !=
                                                                            null
                                                                        ? devices[index]
                                                                            [
                                                                            "locationName"]
                                                                        : "NA",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            13)),
                                                              )
                                                            ])
                                                          ]),
                                                    )
                                                  ]))))));
                        })))));
  }
}
