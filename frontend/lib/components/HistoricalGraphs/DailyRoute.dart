import 'package:frontend/components/HistoricalGraphs/DailyHistoricalGraph.dart';
import 'package:flutter/material.dart';

class DailyRoute extends StatelessWidget {
  DailyRoute.aqi(this.deviceId, this.startDate, this.endDate,
      {this.controllerType = 1});
  DailyRoute.hmi(this.startDate, this.endDate,
      {this.controllerType = 2, this.deviceId});
  final String deviceId;
  final int controllerType;
  final startDate;
  final endDate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme:
            ThemeData(brightness: Brightness.dark, primarySwatch: Colors.green),
        home: Scaffold(
            appBar: AppBar(
              leading:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, size: 30),
                ),
              ]),
            ),
            body: DailyHistoricalGraph.timeSeries(
                this.deviceId, startDate, endDate, controllerType)));
  }
}
