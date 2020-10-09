import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/components/GaugeGraphs/GaugeSegment.dart';
import 'package:frontend/components/helper/Helper.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CustomRect extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height / 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomRect oldClipper) {
    return true;
  }
}

class GaugeGraph extends StatelessWidget {
  GaugeGraph.withoutRange(this.name, this.value, this.unit, this.max,
      {this.range = const [],
      this.arcWidth = 30,
      this.textColor = "#3a9929",
      this.valueColor = "#3a9929"});
  GaugeGraph.withRange(
      this.name, this.valueColor, this.value, this.unit, this.max, this.range,
      {this.arcWidth = 50, this.textColor = "#3a9929"});
  final String valueColor;
  final double value;
  final String unit;
  final double max;
  final int arcWidth;
  final List range;
  final String name;
  final String textColor;
  final helper = new Helper();

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    
    final rangeSeriesList = range.length > 0
        ? (range.map((e) {
            return new GaugeSegment(
                "Range-" + e["value"].toString() + e["color"].toString(),
                e["value"],
                helper.hexToColor(e["color"]));
          }))
        : [
            new GaugeSegment('Range', max, Colors.green),
          ];
    List<Widget> retval = [];
    if (!(range.length > 0)) {
      retval.add(Align(
        alignment: Alignment.center,
        child: Container(
            margin: EdgeInsets.only(bottom: range.length > 0 ? 385 : 187.5),
            child: Text(
              name,
              style: TextStyle(
                  color: helper.hexToColor(textColor),
                  fontSize: range.length > 0 ? 35 : 15,
                  fontWeight: FontWeight.w900),
            )),
      ));
    }
    retval.addAll([
      Padding(
          padding: EdgeInsets.only(top: range.length > 0 ? 20 : 40),
          child: Center(
            child: Text(
              "$value $unit",
              style: TextStyle(
                  color: helper.hexToColor(textColor),
                  fontSize: range.length > 0 ? 30 : 15,
                  fontWeight: FontWeight.w900),
            ),
          )),
      Padding(padding: EdgeInsets.only(
              left: windowWidth / 100 * 2, right: windowWidth / 100 * 2),child:ClipRect(
          clipper: CustomRect(),
          child: new charts.PieChart([
            new charts.Series<GaugeSegment, String>(
              id: 'Range',
              domainFn: (GaugeSegment segment, _) => segment.segment,
              measureFn: (GaugeSegment segment, _) => segment.size,
              colorFn: (GaugeSegment segment, _) => segment.color,
              data: rangeSeriesList.toList(),
            )
          ],
              animate: true,
              defaultRenderer: new charts.ArcRendererConfig(
                  arcWidth: 6,
                  startAngle: pi,
                  arcLength: pi,
                  strokeWidthPx: 0)))),
      Padding(
          padding: EdgeInsets.only(
              left: windowWidth / 100 * 4, right: windowWidth / 100 * 4),
          child: ClipRect(
              clipper: CustomRect(),
              child: new charts.PieChart([
                new charts.Series<GaugeSegment, String>(
                  id: 'Segments',
                  domainFn: (GaugeSegment segment, _) => segment.segment,
                  measureFn: (GaugeSegment segment, _) => segment.size,
                  colorFn: (GaugeSegment segment, _) => segment.color,
                  data: [
                    new GaugeSegment(
                        'Low', value, helper.hexToColor(valueColor)),
                    new GaugeSegment('Back', max - value, Colors.transparent),
                  ],
                )
              ],
                  animate: true,
                  defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: arcWidth,
                      startAngle: pi,
                      arcLength: pi,
                      strokeWidthPx: 0)))),
    ]);
    return Stack(children: retval);
  }
}
