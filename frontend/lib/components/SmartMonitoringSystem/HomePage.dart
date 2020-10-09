import 'dart:ui';

import 'package:frontend/components/GaugeGraphs/GaugeGraph.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/helper/Helper.dart';

class CustomRect extends CustomClipper<Rect> {
  CustomRect(this.top, this.heightDenom);
  final double heightDenom;
  final double top;
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTRB(0, top, size.width, size.height / heightDenom);
    return rect;
  }

  @override
  bool shouldReclip(CustomRect oldClipper) {
    return true;
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width / 100;
    final backGroundColor = Helper().hexToColor("#262626");
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
                child: Stack(children: [
              Container(
                  margin: EdgeInsets.only(
                      left: windowWidth * 5,
                      right: windowWidth * 5,
                      bottom: windowWidth * 5,
                      top: windowWidth * 12.5),
                  height: windowWidth * 12.5,
                  width: windowWidth * 90,
                  color: backGroundColor,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "280.03 TR",
                        style: TextStyle(
                            color: Helper().hexToColor("#33A62F"),
                            fontSize: 40,
                            fontWeight: FontWeight.w900),
                      ))),
              Padding(
                  padding: EdgeInsets.only(top: windowWidth * 5),
                  child: ClipRect(
                      clipper: CustomRect(windowWidth * 22, 1.8),
                      child: Container(
                          margin: EdgeInsets.only(
                              left: windowWidth * 5,
                              right: windowWidth * 5,
                              bottom: windowWidth * 5),
                          height: windowWidth * 135,
                          color: backGroundColor,
                          child: GaugeGraph.withRange(
                              "IKW/TR", "#74CB40", 0.55, "kW/TR", 2, [
                            {"value": 0.5, "color": "#17AF35"},
                            {"value": 0.5, "color": "#74CB40"},
                            {"value": 0.5, "color": "#E08638"},
                            {"value": 0.5, "color": "#A60505"}
                          ])))),
              Padding(
                  padding: EdgeInsets.only(top: windowWidth * 36),
                  child: Row(
                    children: [
                      Expanded(
                          child: ClipRect(
                              clipper: CustomRect(windowWidth * 49, 1.8),
                              child: Container(
                                  margin:
                                      EdgeInsets.only(left: windowWidth * 2),
                                  height: windowWidth * 150,
                                  color: backGroundColor,
                                  child: GaugeGraph.withoutRange(
                                      "Chilled Water Flow",
                                      255.5,
                                      "m\u00B3/hr",
                                      1600)))),
                      Expanded(
                          child: ClipRect(
                              clipper: CustomRect(windowWidth * 49, 1.8),
                              child: Container(
                                  margin: EdgeInsets.only(
                                    left: windowWidth * 2,
                                    right: windowWidth * 2,
                                  ),
                                  height: windowWidth * 150,
                                  color: backGroundColor,
                                  child: GaugeGraph.withoutRange(
                                    "Power Meter",
                                    154,
                                    "kW",
                                    2000,
                                  ))))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: windowWidth * 108.25),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: ClipRect(
                                clipper: CustomRect(windowWidth * 13, 1.65),
                                child: Container(
                                    margin: EdgeInsets.only(
                                      left: windowWidth * 2,
                                    ),
                                    height: windowWidth * 80,
                                    color: backGroundColor,
                                    child: GaugeGraph.withoutRange(
                                      "KWH",
                                      15700,
                                      "kWH",
                                      100000,
                                    )))),
                        Expanded(
                            child: ClipRect(
                                clipper: CustomRect(windowWidth * 13, 1.65),
                                child: Container(
                                    margin: EdgeInsets.only(
                                      left: windowWidth * 2,
                                      right: windowWidth * 2,
                                    ),
                                    height: windowWidth * 80,
                                    color: backGroundColor,
                                    child: GaugeGraph.withoutRange(
                                      "TRH",
                                      28562,
                                      "TRH",
                                      100000,
                                    ))))
                      ],
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: windowWidth * 145.6),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: ClipRect(
                                clipper: CustomRect(windowWidth * 13, 1.65),
                                child: Container(
                                    margin: EdgeInsets.only(
                                      left: windowWidth * 2,
                                    ),
                                    height: windowWidth * 80,
                                    color: backGroundColor,
                                    child: GaugeGraph.withoutRange(
                                      "Condensed Water",
                                      2.95,
                                      "\u0394\u00B0C",
                                      10,
                                    )))),
                        Expanded(
                            child: ClipRect(
                                clipper: CustomRect(windowWidth * 13, 1.65),
                                child: Container(
                                    margin: EdgeInsets.only(
                                      left: windowWidth * 2,
                                      right: windowWidth * 2,
                                    ),
                                    height: windowWidth * 80,
                                    color: backGroundColor,
                                    child: GaugeGraph.withoutRange(
                                      "Chilled Water",
                                      3.89,
                                      "\u0394\u00B0C",
                                      10,
                                    ))))
                      ],
                    ),
                  ))
            ]))));
  }
}
