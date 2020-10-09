import 'package:frontend/JWT/token.dart';
import 'package:frontend/components/AQI/SelectDevice.dart';
import 'package:frontend/components/HistoricalGraphs/DailyHistoricalGraph.dart';
import 'package:frontend/components/HistoricalGraphs/DailyRoute.dart';
import 'package:frontend/components/Loader.dart';
import 'components/Login.dart';
import 'package:frontend/components/ECTS/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Parent());
}

class Parent extends StatefulWidget {
  @override
  _Parent createState() => _Parent();
}

class _Parent extends State<Parent> {
  bool authenticated = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Token().getToken().then((value) => setState(() {
          authenticated = value != null ? true : false;
          loading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EnerGeo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: loading
      //     ? Loader()
      //     : authenticated != false ? SelectDevice() : Login(),
      home: HomePage(),
      // home: DailyRoute.hmi(
      //   DateTime(
      //       DateTime.now().year, DateTime.now().month, DateTime.now().day),
      //   DateTime(DateTime.now().year, DateTime.now().month,
      //       DateTime.now().day, DateTime.now().hour, DateTime.now().minute),
      // )
    );
  }
}
