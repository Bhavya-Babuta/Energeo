import 'package:frontend/components/HistoricalGraphs/DailyHistoricalGraph.dart';
import 'package:frontend/components/HistoricalGraphs/MonthlyHistoricalGraph.dart';
import 'package:flutter/material.dart';

class HistoricalGraph extends StatefulWidget {
  HistoricalGraph(this.deviceId);
  final String deviceId;
  @override
  _HistoricalGraph createState() => _HistoricalGraph();
}

class _HistoricalGraph extends State<HistoricalGraph>
    with AutomaticKeepAliveClientMixin<HistoricalGraph> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                    offset: Offset(20, 120))
              ]),
              constraints: BoxConstraints(maxHeight: 150.0),
              child: Material(
                color: Colors.white,
                child: TabBar(
                  indicatorColor: Colors.green,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "Hourly",
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "Daily",
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.blue[50],
              child: TabBarView(children: [
                DailyHistoricalGraph.bar(
                    widget.deviceId,
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day),
                    DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        DateTime.now().hour,
                        DateTime.now().minute),
                    1),
                MonthlyHistoricalGraph(widget.deviceId)
              ]),
            ))
          ],
        ));
  }
}
