import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:frontend/components/HistoricalGraphs/GraphPoint.dart';

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

class BarGraph extends StatelessWidget {
  BarGraph(
    this.graphData,
    this.graphType, {
    this.animate = true,
  });

  final List<GraphPoint> graphData;
  final bool animate;
  final int graphType;

  List<GraphPoint> getSampleData() {
    var todayDate = DateTime.now();
    var tempDate = new DateTime(todayDate.year, todayDate.month, todayDate.day);
    var nextDate = tempDate.add(Duration(days: 1));
    List<GraphPoint> retval = [];
    while (tempDate.isBefore(nextDate)) {
      retval.add(GraphPoint(tempDate.toString(), Random().nextDouble()));
      tempDate = tempDate.add(Duration(minutes: 60));
    }
    return retval.toList();
  }

  getGraph() {
    if (graphType == 2) {
      return new charts.TimeSeriesChart(
        [
          charts.Series<GraphPoint, DateTime>(
              id: 'value',
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (GraphPoint point, _) => DateTime.parse(point.time),
              measureFn: (GraphPoint point, _) => point.value,
              data: graphData),
        ],
        domainAxis: new charts.DateTimeAxisSpec(
          tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
            hour: new charts.TimeFormatterSpec(
                format: 'Hm', transitionFormat: 'Hm'),
          ),
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
                fontSize: 10,
                color: charts.MaterialPalette
                    .white), //chnage white color as per your requirement.
          ),
        ),
        primaryMeasureAxis: new charts.NumericAxisSpec(
            renderSpec: charts.GridlineRendererSpec(
              labelStyle: charts.TextStyleSpec(
                  fontSize: 10,
                  color: charts.MaterialPalette
                      .white), //chnage white color as per your requirement.
            ),
            tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                desiredTickCount: 15,
                dataIsInWholeNumbers: false,
                zeroBound: false)),
        defaultRenderer: new charts.LineRendererConfig(
          includeArea: true,
        ),
        animate: this.animate,
      );
    }
    return new charts.BarChart(
      [
        charts.Series<GraphPoint, String>(
            id: 'value',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (GraphPoint point, _) {
              String retval =
                  point.time.toString().split(" ")[1].substring(0, 2);
              if (int.parse(retval) == 0) {
                return "12AM";
              }

              retval += int.parse(retval) < 12 ? "AM" : "PM";
              if (retval.startsWith("0")) {
                retval = retval.replaceFirst("0", "");
              }
              return retval;
            },
            measureFn: (GraphPoint point, _) => point.value,
            data: graphData),
      ],
      behaviors: [
        new charts.PanAndZoomBehavior(),
        new charts.SelectNearest(),
        new charts.DomainHighlighter()
      ],
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(labelRotation: 85),
      ),
      animate: this.animate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: graphType == 2 ? 465 : 472.5,
      child: Stack(children: [
        Stack(children: [
          Padding(
              padding: EdgeInsets.only(top: 20, left: 25),
              child: Icon(FlutterIcons.weather_night_mco)),
          Opacity(
              opacity: 0.25,
              child: Container(
                width: 82.5,
                height: 380,
                color: Colors.black,
              ))
        ]),
        Align(
            alignment: Alignment.topRight,
            child: Stack(children: [
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 25),
                  child: Icon(FlutterIcons.weather_night_mco)),
              Opacity(
                  opacity: 0.25,
                  child: Container(
                    width: 82.5,
                    height: 380,
                    color: Colors.black,
                  ))
            ])),
        Expanded(
            child: Container(
                height: graphType == 2 ? 400 : 475, child: getGraph())),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Icon(FlutterIcons.wi_sunrise_wea),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: ButtonBar(
            children: [
              RaisedButton(
                child: Text("Convert to CSV"),
                color: Colors.green,
                onPressed: () {},
              ),
              RaisedButton(
                child: Text("Convert to PDF"),
                color: Colors.green,
                onPressed: () {},
              )
            ],
            alignment: MainAxisAlignment.center,
          ),
        )
      ]),
    );
  }
}
