import 'package:frontend/components/helper/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'dart:math';

class RadialGraphs extends StatelessWidget {
  RadialGraphs(this.data, this.colorData);
  final data;
  final colorData;
  final double radial = 75;
  final double radialWhite = 25;
  final helper = new Helper();

  double maximumAttributeValue(attribute) {
    final a = {
      "PM2.5": 250.0,
      "PM10": 430.0,
      "PM1": 100.0,
      "Temperature": 50.0,
      "Humidity": 100.0,
      "CO2": 2500.0,
      "TVOC": 500.0,
      "AQI": 0.0
    };
    return a[attribute];
  }

  Widget getTemHumidityGraph(width, height) {
    final graphSize = height * 40;
    final fontSize = width * 3.5;
    return Stack(children: <Widget>[
      Transform.rotate(
          angle: -pi / 1.0,
          child: Center(
              child: AnimatedCircularChart(
            key: GlobalKey<AnimatedCircularChartState>(),
            size: Size(graphSize, width * 70),
            initialChartData: <CircularStackEntry>[
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(
                      radial /
                          maximumAttributeValue("Temperature") *
                          data["Temperature"],
                      helper.hexToColor(colorData["Temperature"]),
                      rankKey: 'Q1'),
                  new CircularSegmentEntry(
                      radial -
                          radial /
                              maximumAttributeValue("Temperature") *
                              data["Temperature"],
                      helper.hexToColor("#546E7A"),
                      rankKey: 'Q2'),
                  new CircularSegmentEntry(radialWhite, Colors.white12,
                      rankKey: 'Q2'),
                ],
                rankKey: 'Quarterly Profits',
              ),
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(
                      radial /
                          maximumAttributeValue("Humidity") *
                          data["Humidity"],
                      helper.hexToColor(colorData["Humidity"]),
                      rankKey: 'Q1'),
                  new CircularSegmentEntry(
                      radial -
                          radial /
                              maximumAttributeValue("Humidity") *
                              data["Humidity"],
                      helper.hexToColor("#546E7A"),
                      rankKey: 'Q2'),
                  new CircularSegmentEntry(radialWhite, Colors.white12,
                      rankKey: 'Q2'),
                ],
                rankKey: 'Quarterly Profits',
              ),
            ],
            chartType: CircularChartType.Radial,
            edgeStyle: SegmentEdgeStyle.round,
            // holeLabel: data.keys.toList()[index],
          ))),
      Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.only(top: width * 57.25, left: width * 53),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(bottom: width * 1),
                  child: Row(
                    children: <Widget>[
                      Text(
                        " - " + data["Temperature"].toStringAsFixed(0),
                        style: TextStyle(
                            color: helper.hexToColor(colorData["Temperature"]),
                            fontSize: fontSize),
                      ),
                      Text(" Temperature",
                          style: TextStyle(fontSize: fontSize)),
                    ],
                  )),
              Row(
                children: <Widget>[
                  Text(
                    " - " + data["Humidity"].toStringAsFixed(0),
                    style: TextStyle(
                        color: helper.hexToColor(colorData["Humidity"]),
                        fontSize: fontSize),
                  ),
                  Text(" Humidity", style: TextStyle(fontSize: fontSize)),
                ],
              ),
            ]),
          ))
    ]);
  }

  Widget getPMGraph(width, height) {
    final graphSize = height * 40;
    final fontSize = width * 3.5;

    return Stack(children: <Widget>[
      Transform.rotate(
          angle: -pi / 1.0,
          child: Center(
              child: AnimatedCircularChart(
            key: GlobalKey<AnimatedCircularChartState>(),
            size: Size(graphSize, 275),
            initialChartData: <CircularStackEntry>[
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(
                      radial / maximumAttributeValue("PM2.5") * data["PM2.5"],
                      helper.hexToColor(colorData["PM2.5"]),
                      rankKey: 'Q1'),
                  new CircularSegmentEntry(
                      radial -
                          radial /
                              maximumAttributeValue("PM2.5") *
                              data["PM2.5"],
                      helper.hexToColor("#546E7A"),
                      rankKey: 'Q2'),
                  new CircularSegmentEntry(radialWhite, Colors.white12,
                      rankKey: 'Q2'),
                ],
                rankKey: 'Quarterly Profits',
              ),
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(
                      (radial / maximumAttributeValue("PM1")) * data["PM1"],
                      helper.hexToColor(colorData["PM1"]),
                      rankKey: 'Q1'),
                  new CircularSegmentEntry(
                      radial -
                          radial / maximumAttributeValue("PM1") * data["PM1"],
                      helper.hexToColor("#546E7A"),
                      rankKey: 'Q2'),
                  new CircularSegmentEntry(radialWhite, Colors.white12,
                      rankKey: 'Q2'),
                ],
                rankKey: 'Quarterly Profits',
              ),
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(
                      radial / maximumAttributeValue("PM10") * data["PM10"],
                      helper.hexToColor(colorData["PM10"]),
                      rankKey: 'Q1'),
                  new CircularSegmentEntry(
                      radial -
                          radial / maximumAttributeValue("PM10") * data["PM10"],
                      helper.hexToColor("#546E7A"),
                      rankKey: 'Q2'),
                  new CircularSegmentEntry(radialWhite, Colors.white12,
                      rankKey: 'Q2'),
                ],
                rankKey: 'Quarterly Profits',
              ),
            ],
            chartType: CircularChartType.Radial,
            edgeStyle: SegmentEdgeStyle.round,
            // holeLabel: data.keys.toList()[index],
          ))),
      Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.only(top: width * 51.5, left: width * 53),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(bottom: width * 1),
                  child: Row(
                    children: <Widget>[
                      Text(
                        " - " + data["PM2.5"].toStringAsFixed(0),
                        style: TextStyle(
                            color: helper.hexToColor(colorData["PM2.5"]),
                            fontSize: fontSize),
                      ),
                      Text(" PM2.5", style: TextStyle(fontSize: fontSize)),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(bottom: width * 1),
                  child: Row(
                    children: <Widget>[
                      Text(
                        " - " + data["PM1"].toStringAsFixed(0),
                        style: TextStyle(
                            color: helper.hexToColor(colorData["PM1"]),
                            fontSize: fontSize),
                      ),
                      Text(" PM1", style: TextStyle(fontSize: fontSize)),
                    ],
                  )),
              Row(
                children: <Widget>[
                  Text(
                    " - " + data["PM10"].toStringAsFixed(0),
                    style: TextStyle(
                        color: helper.hexToColor(colorData["PM10"]),
                        fontSize: fontSize),
                  ),
                  Text(" PM10", style: TextStyle(fontSize: fontSize)),
                ],
              ),
            ]),
          ))
    ]);
  }

  Widget getC02TVOCGraph(width, height) {
    final fontSize = width * 3.5;
    final graphSize = height * 40;

    return Stack(children: <Widget>[
      Transform.rotate(
          angle: -pi / 1.0,
          child: Center(
              child: AnimatedCircularChart(
            key: GlobalKey<AnimatedCircularChartState>(),
            size: Size(graphSize, width * 70),
            initialChartData: <CircularStackEntry>[
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(
                      radial / maximumAttributeValue("CO2") * data["CO2"],
                      helper.hexToColor(colorData["CO2"]),
                      rankKey: 'Q1'),
                  new CircularSegmentEntry(
                      radial -
                          radial / maximumAttributeValue("CO2") * data["CO2"],
                      helper.hexToColor("#546E7A"),
                      rankKey: 'Q2'),
                  new CircularSegmentEntry(radialWhite, Colors.white12,
                      rankKey: 'Q2'),
                ],
                rankKey: 'Quarterly Profits',
              ),
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(
                      radial / maximumAttributeValue("TVOC") * data["TVOC"],
                      helper.hexToColor(colorData["TVOC"]),
                      rankKey: 'Q1'),
                  new CircularSegmentEntry(
                      radial -
                          radial / maximumAttributeValue("TVOC") * data["TVOC"],
                      helper.hexToColor("#546E7A"),
                      rankKey: 'Q2'),
                  new CircularSegmentEntry(radialWhite, Colors.white12,
                      rankKey: 'Q2'),
                ],
                rankKey: 'Quarterly Profits',
              ),
            ],
            chartType: CircularChartType.Radial,
            edgeStyle: SegmentEdgeStyle.round,
            // holeLabel: data.keys.toList()[index],
          ))),
      Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.only(top: width * 57.25, left: width * 53),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(bottom: width * 1),
                  child: Row(
                    children: <Widget>[
                      Text(
                        " - " + data["CO2"].toStringAsFixed(0),
                        style: TextStyle(
                            color: helper.hexToColor(colorData["CO2"]),
                            fontSize: fontSize),
                      ),
                      Text(" CO2", style: TextStyle(fontSize: fontSize)),
                    ],
                  )),
              Row(
                children: <Widget>[
                  Text(
                    " - " + data["TVOC"].toStringAsFixed(0),
                    style: TextStyle(
                        color: helper.hexToColor(colorData["TVOC"]),
                        fontSize: fontSize),
                  ),
                  Text(" TVOC", style: TextStyle(fontSize: fontSize)),
                ],
              ),
            ]),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 100;
    final height = MediaQuery.of(context).size.height / 100;
    return SingleChildScrollView(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: width * 5, bottom: width * 7.5),
                  child: getPMGraph(width, height)),
              Padding(
                  padding: EdgeInsets.only(bottom: width * 7.5),
                  child: getC02TVOCGraph(width, height)),
              Padding(
                  padding: EdgeInsets.only(bottom: width * 7.5),
                  child: getTemHumidityGraph(width, height))
            ])));
  }
}
