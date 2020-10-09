import 'package:frontend/JWT/token.dart';
import 'package:frontend/components/BarTimeSeriesGraph/BarTimeSeriesGraph.dart';
import 'package:frontend/components/HistoricalGraphs/GraphPoint.dart';
import 'package:frontend/components/Loader.dart';
import 'package:frontend/components/helper/Helper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lottie/lottie.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart'
    as OverlayLoader;

class DailyHistoricalGraph extends StatefulWidget {
  DailyHistoricalGraph.bar(
      this.deviceId, this.startDate, this.endDate, this.controllerType,
      {this.graphType = 1});
  DailyHistoricalGraph.timeSeries(
      this.deviceId, this.startDate, this.endDate, this.controllerType,
      {this.graphType = 2});
  final String deviceId;
  final DateTime startDate;
  final DateTime endDate;
  final int controllerType;
  final int graphType;
  @override
  _DailyHistoricalGraph createState() => _DailyHistoricalGraph();
}

class _DailyHistoricalGraph extends State<DailyHistoricalGraph>
    with AutomaticKeepAliveClientMixin<DailyHistoricalGraph> {
  @override
  bool get wantKeepAlive => true;
  Helper helper = new Helper();

  String selectedButton;
  DateTime startDate;
  DateTime endDate;
  List data = [];
  bool loading = true;
  bool animate = true;
  Map<String, List<GraphPoint>> graphData = {};
  List<charts.TickSpec<DateTime>> dailyChartTicks = [];
  List<GraphPoint> timeLine = [];
  Map<String, String> averageValues = {};

  List<Map> getSampleData() {
    var tempDate = new DateTime(startDate.year, startDate.month, startDate.day);
    var nextDate = tempDate.add(Duration(days: 1));
    List<Map> retval = [
      {"time": "2020-09-15 01:00:00", "ikw/tr": 0.42},
      {"time": "2020-09-15 01:30:00", "ikw/tr": 0.41},
      {"time": "2020-09-15 02:00:00", "ikw/tr": 0.42},
      {"time": "2020-09-15 02:30:00", "ikw/tr": 0.41},
      {"time": "2020-09-15 03:00:00", "ikw/tr": 0.43},
      {"time": "2020-09-15 03:30:00", "ikw/tr": 0.42},
      {"time": "2020-09-15 04:00:00", "ikw/tr": 0.44},
      {"time": "2020-09-15 04:30:00", "ikw/tr": 0.46},
      {"time": "2020-09-15 05:00:00", "ikw/tr": 0.45},
      {"time": "2020-09-15 05:30:00", "ikw/tr": 0.45},
      {"time": "2020-09-15 06:00:00", "ikw/tr": 0.46},
      {"time": "2020-09-15 06:30:00", "ikw/tr": 0.45},
      {"time": "2020-09-15 07:00:00", "ikw/tr": 0.45},
      {"time": "2020-09-15 07:30:00", "ikw/tr": 0.47},
      {"time": "2020-09-15 08:00:00", "ikw/tr": 0.48},
      {"time": "2020-09-15 08:30:00", "ikw/tr": 0.50},
      {"time": "2020-09-15 09:00:00", "ikw/tr": 0.51},
      {"time": "2020-09-15 09:30:00", "ikw/tr": 0.51},
      {"time": "2020-09-15 10:00:00", "ikw/tr": 0.50},
      {"time": "2020-09-15 10:30:00", "ikw/tr": 0.53},
      {"time": "2020-09-15 11:00:00", "ikw/tr": 0.56},
      {"time": "2020-09-15 11:30:00", "ikw/tr": 0.58},
      {"time": "2020-09-15 12:00:00", "ikw/tr": 0.60},
      {"time": "2020-09-15 12:30:00", "ikw/tr": 0.61},
      {"time": "2020-09-15 13:00:00", "ikw/tr": 0.62},
      {"time": "2020-09-15 13:30:00", "ikw/tr": 0.63},
      {"time": "2020-09-15 14:00:00", "ikw/tr": 0.64},
      {"time": "2020-09-15 14:30:00", "ikw/tr": 0.65},
      {"time": "2020-09-15 15:00:00", "ikw/tr": 0.67},
      {"time": "2020-09-15 15:30:00", "ikw/tr": 0.66},
      {"time": "2020-09-15 16:00:00", "ikw/tr": 0.65},
      {"time": "2020-09-15 16:30:00", "ikw/tr": 0.64},
      {"time": "2020-09-15 17:00:00", "ikw/tr": 0.63},
      {"time": "2020-09-15 17:30:00", "ikw/tr": 0.64},
      {"time": "2020-09-15 18:00:00", "ikw/tr": 0.61},
      {"time": "2020-09-15 18:30:00", "ikw/tr": 0.58},
      {"time": "2020-09-15 19:00:00", "ikw/tr": 0.57},
      {"time": "2020-09-15 19:30:00", "ikw/tr": 0.56},
      {"time": "2020-09-15 20:00:00", "ikw/tr": 0.53},
      {"time": "2020-09-15 20:30:00", "ikw/tr": 0.51},
      {"time": "2020-09-15 21:00:00", "ikw/tr": 0.53},
      {"time": "2020-09-15 21:30:00", "ikw/tr": 0.49},
      {"time": "2020-09-15 22:00:00", "ikw/tr": 0.47},
      {"time": "2020-09-15 22:30:00", "ikw/tr": 0.46},
      {"time": "2020-09-15 23:00:00", "ikw/tr": 0.43},
      {"time": "2020-09-15 23:30:00", "ikw/tr": 0.42},
    ];
    // while (tempDate.isBefore(nextDate)) {
    //   retval.add(
    //       {"time": tempDate.toString(), "ikw/tr": Random().nextInt(200) / 100});
    //   tempDate = tempDate.add(Duration(minutes: 30));
    // }
    return retval.toList();
  }

  Future<List> _getDataUi() async {
    switch (widget.controllerType) {
      case 1:
        final authToken = await Token().getToken();
        if (!(data.length > 0)) {
          return await http.post(
              "https://dashboard.airveda.com/api/data/historical/",
              body: {
                "deviceId": widget.deviceId,
                "startTime": DateFormat('yyyy-MM-dd HH:mm:ss')
                    .format(startDate)
                    .toString(),
                "endTime":
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(endDate).toString()
              },
              headers: {
                "Authorization": "Bearer $authToken"
              }).then((result) => result.statusCode == 200 && mounted
              ? json.decode(result.body)["data"]
              : null);
        }
        break;
      case 2:
        var data = getSampleData();
        return data;
        break;
    }
    return null;
  }

  Map getGraphData(data, attribute) {
    Map retval = {};
    double average = 0.0;
    List<GraphPoint> graphPoints = [];
    var graphPointsCount = 0;
    for (var i = 0; i < timeLine.length; i++) {
      for (var j = 0; j < data.length; j++) {
        if (helper.checkDateEqual(DateTime.parse(timeLine[i].time),
            DateTime.parse(data[j]["time"]))) {
          average += data[j][attribute].toDouble();
          graphPointsCount += 1;
          graphPoints
              .add(GraphPoint(timeLine[i].time, data[j][attribute].toDouble()));
          break;
        } else {
          if (widget.graphType == 1) {
            graphPoints.add(timeLine[i]);
          }
        }
      }
    }
    if (average > 0 && graphPointsCount > 0 && graphPoints.length > 0) {
      retval["average"] = (average / graphPointsCount).toStringAsFixed(3);
      retval["graphPoints"] = graphPoints;
    }
    return retval;
  }

  Map getTimeDomain() {
    Map retval = {};
    List<GraphPoint> initialTimeLine = [];
    List<charts.TickSpec<DateTime>> chartTicks = [];
    var tempDate = new DateTime(startDate.year, startDate.month, startDate.day);
    chartTicks.add(charts.TickSpec<DateTime>(
      DateTime(tempDate.year, tempDate.month, tempDate.day, tempDate.hour,
          tempDate.minute),
    ));
    initialTimeLine.add(GraphPoint(
        DateTime(tempDate.year, tempDate.month, tempDate.day, tempDate.hour,
                tempDate.minute)
            .toString(),
        0.0));
    while (tempDate.isBefore(endDate) ||
        helper.checkDateEqual(tempDate, endDate)) {
      chartTicks.add(charts.TickSpec<DateTime>(
        DateTime(tempDate.year, tempDate.month, tempDate.day, tempDate.hour,
            tempDate.minute + 30),
      ));
      initialTimeLine.add(GraphPoint(
          DateTime(tempDate.year, tempDate.month, tempDate.day, tempDate.hour,
                  tempDate.minute + 30)
              .toString(),
          0.0));
      tempDate = DateTime(tempDate.year, tempDate.month, tempDate.day,
          tempDate.hour, tempDate.minute + 30);
    }

    setState(() {
      dailyChartTicks = chartTicks;
      timeLine = initialTimeLine;
    });
    return retval;
  }

  void getHistoricalDayData() {
    OverlayLoader.Loader.show(this.context,
        overlayColor: Colors.black38,
        progressIndicator: CircularProgressIndicator());

    getTimeDomain();
    _getDataUi().then((value) {
      getRenderData(value);
      OverlayLoader.Loader.hide();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      startDate = widget.startDate;
      endDate = widget.endDate;
    });
    getHistoricalDayData();
    setState(() {
      selectedButton = widget.controllerType == 2 ? "ikw/tr" : "aqi";
      loading = false;
    });
  }

  void getRenderData(value) {
    if (value != null && value.length > 0) {
      Map<String, List<GraphPoint>> graphPoints = {};
      Map<String, String> averages = {};
      final keys = value[0].keys.toList();
      for (var i = 0; i < keys.length; i++) {
        if (keys[i] != "time") {
          var renderData = getGraphData(value, keys[i]);
          if (keys[i] == "pm25") {
            graphPoints["pm2.5"] = renderData["graphPoints"];
            averages["pm2.5"] = renderData["average"];
          } else {
            graphPoints[keys[i]] = renderData["graphPoints"];
            averages[keys[i]] = renderData["average"];
          }
        }
      }
      setState(() {
        graphData = graphPoints;
        averageValues = averages;
      });
    } else {
      setState(() {
        graphData = null;
      });
    }
  }

  Future<List> handleRefresh() async {
    getHistoricalDayData();
    return [];
  }

  List<RaisedButton> getAttributeButtons(List<String> attributes) => attributes
      .map((element) => new RaisedButton(
            child: Text(element.replaceAll("_", " ").toUpperCase()),
            color: selectedButton == element
                ? helper.hexToColor("#3a9929")
                : Colors.white,
            onPressed: () => setState(() {
              selectedButton = element;
            }),
          ))
      .toList();

  getUpdatedHistoricalDataFromNewDate(newStartDate) {
    setState(() {
      startDate = newStartDate;
      endDate = newStartDate.add(Duration(days: 1));
    });
    getHistoricalDayData();
  }

  List<Widget> getActionableDayElement() {
    void getNextDayData() {
      final newStartDate = startDate.add(Duration(days: 1));
      if (!newStartDate.isAfter(DateTime.now())) {
        getUpdatedHistoricalDataFromNewDate(newStartDate);
      }
    }

    void getPreviousDayData() {
      final newStartDate = startDate.subtract(Duration(days: 1));
      getUpdatedHistoricalDataFromNewDate(newStartDate);
    }

    var retval = [
      IconButton(
        icon: Icon(Ionicons.ios_arrow_back),
        onPressed: () => getPreviousDayData(),
      ),
      Container(
        child: Text(helper.getStartDateText(startDate)),
      ),
    ];
    final newStartDate = startDate.add(Duration(days: 1));

    if (!newStartDate.isAfter(DateTime.now())) {
      retval.add(
        IconButton(
          icon: Icon(Ionicons.ios_arrow_forward),
          onPressed: () => getNextDayData(),
        ),
      );
    }
    return retval;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != startDate) {
      getUpdatedHistoricalDataFromNewDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final topRowAttributeButtons =
        helper.getTopRowAttributeButtons(widget.controllerType);
    final bottomRowAttributeButton =
        helper.getBottomRowAttributeButtons(widget.controllerType);

    final windowWidth = MediaQuery.of(context).size.width / 100;
    return loading && graphData[selectedButton] == null
        ? Loader()
        : RefreshIndicator(
            onRefresh: () async {
              await handleRefresh();
            },
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: getActionableDayElement(),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.green,
                            ),
                            tooltip: 'Date Time Range',
                            onPressed: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                      ]),
                  ButtonBar(
                    children: getAttributeButtons(topRowAttributeButtons),
                    alignment: MainAxisAlignment.center,
                  ),
                  ButtonBar(
                    children: getAttributeButtons(bottomRowAttributeButton),
                    alignment: MainAxisAlignment.center,
                  ),
                  graphData != null &&
                          graphData[selectedButton] != null &&
                          graphData[selectedButton].length > 0
                      ? SafeArea(
                          child: Column(children: [
                          Column(
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: windowWidth * 1),
                                  child: Text(
                                    "Daily Average Value",
                                    style: TextStyle(
                                        fontSize: windowWidth * 4,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[500]),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: windowWidth * 2,
                                      bottom: windowWidth * 2),
                                  child: Text(
                                    averageValues[selectedButton].toString(),
                                    style: TextStyle(
                                        fontSize: windowWidth * 8,
                                        fontWeight: FontWeight.w800,
                                        color: helper.hexToColor(
                                            helper.getAverageValueColor(
                                                selectedButton,
                                                averageValues[
                                                    selectedButton])["color"])),
                                  )),
                              Padding(
                                  padding:
                                      EdgeInsets.only(bottom: windowWidth * 5),
                                  child: Container(
                                      width: windowWidth * 75,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: helper.hexToColor(
                                              helper.getAverageValueColor(
                                                      selectedButton,
                                                      averageValues[
                                                          selectedButton])[
                                                  "color"])),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: windowWidth * 0.5,
                                              bottom: windowWidth * 0.5),
                                          child: Center(
                                              child: Text(
                                            helper.getAverageValueColor(
                                                selectedButton,
                                                averageValues[
                                                    selectedButton])["text"],
                                            style: TextStyle(
                                                fontSize: windowWidth * 5,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white),
                                          ))))),
                              BarGraph(
                                  graphData[selectedButton], widget.graphType)
                            ],
                          ),
                        ]))
                      : Padding(
                          padding: EdgeInsets.fromLTRB(windowWidth * 10,
                              windowWidth * 5, windowWidth * 5, 0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(children: [
                              Lottie.asset('assets/no-data.json'),
                              Text(
                                "No Chart Data Available",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: windowWidth * 5,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          )),
                ])));
  }

  @override
  void dispose() {
    OverlayLoader.Loader.hide();
    super.dispose();
  }
}
