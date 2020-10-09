import 'package:frontend/JWT/token.dart';
import 'package:frontend/components/HistoricalGraphs/DailyRoute.dart';
import 'package:frontend/components/helper/Helper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class MonthlyHistoricalGraph extends StatefulWidget {
  MonthlyHistoricalGraph(this.deviceId);
  final String deviceId;
  @override
  _MonthlyHistoricalGraph createState() => _MonthlyHistoricalGraph();
}

class _MonthlyHistoricalGraph extends State<MonthlyHistoricalGraph>
    with AutomaticKeepAliveClientMixin<MonthlyHistoricalGraph> {
  @override
  bool get wantKeepAlive => true;
  Helper helper = new Helper();

  String selectedButton = "aqi";
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  List data = [];
  bool loading = false;
  bool animate = false;
  Map<String, String> averageValues = {};
  String _currentMonth = DateFormat.yMMMM().format(DateTime.now());

  Future<List> _getDataUi() async {
    final authToken = await Token().getToken();
    if (!(data.length > 0 || data.length > 0)) {
      var result = await http
          .post("https://dashboard.airveda.com/api/data/historical/", body: {
        "deviceId": widget.deviceId,
        "startTime":
            DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate).toString(),
        "endTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(endDate).toString()
      }, headers: {
        "Authorization": "Bearer $authToken"
      });
      if (result.statusCode == 200 && mounted) {
        return json.decode(result.body)["data"];
      } else {
        return null;
      }
    }
    return null;
  }

  List<RaisedButton> getTopLayerButtons() => ["aqi", "pm2.5", "pm10", "pm1"]
      .map((element) => new RaisedButton(
            child: Text(element.toUpperCase()),
            color: selectedButton == element ? Colors.green : Colors.white,
            onPressed: () => setState(() {
              selectedButton = element;
            }),
          ))
      .toList();

  List<RaisedButton> getBottomLayerButtons() =>
      ["temperature", "humidity", "voc", "co2"]
          .map((element) => new RaisedButton(
              child: Text(element.toUpperCase()),
              color: selectedButton == element ? Colors.green : Colors.white,
              onPressed: () => setState(() {
                    selectedButton = element;
                  })))
          .toList();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonBar(
                  children: getTopLayerButtons(),
                  alignment: MainAxisAlignment.center,
                ),
                ButtonBar(
                  children: getBottomLayerButtons(),
                  alignment: MainAxisAlignment.center,
                ),
                SafeArea(
                    child: Column(children: [
                  Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Monthly Average Value",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[500]),
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: Text(
                            averageValues[selectedButton] != null
                                ? averageValues[selectedButton]
                                : "NA",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: helper.hexToColor(
                                    helper.getAverageValueColor(selectedButton,
                                            averageValues[selectedButton])[
                                        "color"])),
                          ))
                    ],
                  )
                ])),
                CalendarCarousel(
                  height: 500,
                  onCalendarChanged: (DateTime date) {
                    this.setState(() {
                      startDate = date;
                      _currentMonth = DateFormat.yMMMM().format(startDate);
                    });
                  },
                  onDayPressed: (DateTime date, _) {
                    this.setState(() => setState(() {
                          startDate = date;
                        }));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DailyRoute.aqi(
                                widget.deviceId,
                                date,
                                DateTime(
                                    date.year, date.month, date.day + 1))));
                  },
                  weekendTextStyle: TextStyle(
                    color: Colors.red,
                  ),
                  thisMonthDayBorderColor: Colors.blue,
                  headerText: _currentMonth,
                  weekFormat: false,
                  selectedDateTime: startDate,
                  daysHaveCircularBorder: false,

                  /// null for not rendering any border, true for circular border, false for rectangular border
                  customGridViewPhysics: NeverScrollableScrollPhysics(),
                  markedDateShowIcon: true,
                  selectedDayTextStyle: TextStyle(
                    color: Colors.yellow,
                  ),
                  todayTextStyle: TextStyle(
                    color: Colors.blue,
                  ),
                  markedDateIconBuilder: (event) {
                    return event.icon;
                  },
                  minSelectedDate: startDate.subtract(Duration(days: 360)),
                  maxSelectedDate: DateTime.now(),
                  todayButtonColor: Colors.transparent,
                  markedDateMoreShowTotal:
                      null, // null for not showing hidden events indicator
                  dayPadding: 1,
                  markedDateIconBorderColor: Colors.red,
                )
              ]),
        ));
  }
}
