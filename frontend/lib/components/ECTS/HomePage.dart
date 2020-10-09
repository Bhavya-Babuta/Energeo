import 'dart:ui';

import 'package:frontend/components/GaugeGraphs/GaugeGraph.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/helper/Helper.dart';

class CustomRect extends CustomClipper<Rect> {
  CustomRect(this.top, this.heightDenom);
  final double heightDenom;
  final double top;
  @override
  Rect getClip(Size size) =>
      Rect.fromLTRB(0, top, size.width, size.height / heightDenom);

  @override
  bool shouldReclip(CustomRect oldClipper) => true;
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width / 100;
    final backGroundColor = Helper().hexToColor("#262626");
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Image.asset(
                'assets/logo/logo.png',
                width: 150,
                fit: BoxFit.cover,
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
                child: Stack(children: [
              ClipRect(
                  clipper: CustomRect(windowWidth * 2, 1.6),
                  child: Container(
                      margin: EdgeInsets.only(
                          left: windowWidth * 5,
                          right: windowWidth * 5,
                          bottom: windowWidth * 5),
                      height: windowWidth * 65,
                      color: backGroundColor,
                      child: GaugeGraph.withoutRange("", 7.6, "PH", 14))),
              Padding(
                  padding: EdgeInsets.only(top: windowWidth * 42.5),
                  child: ClipRect(
                      clipper: CustomRect(windowWidth * 2, 1.6),
                      child: Container(
                          margin: EdgeInsets.only(
                              left: windowWidth * 5,
                              right: windowWidth * 5,
                              bottom: windowWidth * 5),
                          height: windowWidth * 65,
                          color: backGroundColor,
                          child: GaugeGraph.withoutRange(
                              "", 3200, "COND", 10000)))),
              Padding(
                  padding: EdgeInsets.only(top: windowWidth * 85),
                  child: ClipRect(
                      clipper: CustomRect(windowWidth * 2, 1.65),
                      child: Container(
                          margin: EdgeInsets.only(
                              left: windowWidth * 5,
                              right: windowWidth * 5,
                              bottom: windowWidth * 5),
                          height: windowWidth * 65,
                          color: backGroundColor,
                          child:
                              GaugeGraph.withoutRange("", 93, "AMPS", 200)))),
              Padding(
                  padding: EdgeInsets.only(top: windowWidth * 126.25),
                  child: ClipRect(
                      clipper: CustomRect(windowWidth * 2, 1.65),
                      child: Container(
                          margin: EdgeInsets.only(
                              left: windowWidth * 5,
                              right: windowWidth * 5,
                              bottom: windowWidth * 5),
                          height: windowWidth * 65,
                          color: backGroundColor,
                          child:
                              GaugeGraph.withoutRange("", 11.6, "VOLTS", 15))))
            ]))));
  }
}
