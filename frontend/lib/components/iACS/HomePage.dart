import 'dart:ui';

import 'package:frontend/components/GaugeGraphs/GaugeGraph.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/helper/Helper.dart';

class CustomRect extends CustomClipper<Rect> {
  CustomRect(this.top, this.heightDenom);
  final double heightDenom;
  final double top;
  @override
  Rect getClip(Size size) => Rect.fromLTRB(0, top, size.width, size.height / heightDenom);
    
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
                        "268.20 TR",
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
                              "IKW/TR", "#74CB40", 0.71, "kW/TR", 3, [
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
                                      122,
                                      "m\u00B3/hr",
                                      1200)))),
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
                                    192.2,
                                    "kW",
                                    600,
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
                                      38460,
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
                                      53640,
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
                                      "OAT (Outside Air Temp)",
                                      40,
                                      "\u00B0C",
                                      65,
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
                                      5,
                                      "\u0394\u00B0C",
                                      14,
                                    ))))
                      ],
                    ),
                  )),              Padding(
                  padding: EdgeInsets.only(top: windowWidth * 183),
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
                                      "Post Cooling Temp",
                                      25,
                                      "\u0394\u00B0C",
                                      50,
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
                                      "RH",
                                      45,
                                      "%",
                                      100,
                                    ))))
                      ],
                    ),
                  ))
            ]))));
  }
}
