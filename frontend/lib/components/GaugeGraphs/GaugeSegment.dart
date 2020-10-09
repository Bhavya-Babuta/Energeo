import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class GaugeSegment {
  final String segment;
  final double size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
