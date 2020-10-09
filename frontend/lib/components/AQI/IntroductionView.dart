import 'package:frontend/components/RadialGraphs/RadialGraphs.dart';
import 'package:frontend/components/helper/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'Battery.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroductionView extends StatelessWidget {
  IntroductionView(
      this.deviceData, this.data, this.lastUpdatedSeconds, this.colorData);
  final data;
  final lastUpdatedSeconds;
  final deviceData;
  final colorData;
  final helper = new Helper();

  String getAQIEquivalentString(value) {
    if (value > 0 && value <= 50) {
      return "Good";
    } else if (value >= 51 && value <= 100) {
      return "Satisfactory";
    } else if (value >= 101 && value <= 200) {
      return "Moderately Polluted";
    } else if (value >= 201 && value <= 300) {
      return "Poor";
    } else if (value >= 301 && value <= 400) {
      return "Very Poor";
    } else if (value >= 401 && value <= 500) {
      return "Severe";
    }
    return "";
  }

  String getlastUpdatedValue() {
    if (lastUpdatedSeconds / 60 > 0.0 && lastUpdatedSeconds / 60 < 60.0) {
      // Return minutes
      return (lastUpdatedSeconds / 60).toStringAsFixed(0) + " minutes ago";
    } else if (lastUpdatedSeconds / 3600 > 0.0 &&
        lastUpdatedSeconds / 3600 <= 24.0) {
      return (lastUpdatedSeconds / 3600).toStringAsFixed(0) + " hours ago";
    } else if (lastUpdatedSeconds / 3600 > 24.0 && lastUpdatedSeconds <= 48.0) {
      return "Yesterday";
    } else if (lastUpdatedSeconds / 3600 / 24 > 1.0 &&
        lastUpdatedSeconds / 3600 / 24 < 30) {
      return (lastUpdatedSeconds / 3600 / 24).toStringAsFixed(0) + " days ago";
    }
    return lastUpdatedSeconds.toString() + " seconds ago";
  }

  @override
  Widget build(BuildContext context) {
    final lastUpdated = getlastUpdatedValue();
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        allowFontScaling: true);
    final width = MediaQuery.of(context).size.width / 100;
    final height = MediaQuery.of(context).size.height / 100;
    List<Widget> getAttributeNames() {
      List<Widget> list = List<Widget>();
      for (var a in data.keys) {
        if (a != "Temperature" && a != "Humidity") {
          list.add(TableCell(
              child: Center(
                  child: Text(a,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(13.w.ssp),
                      ),
                      maxLines: 1))));
        }
      }
      return list;
    }

    getTemperatureTextWidget() {
      return new Row(children: [
        Icon(
          FontAwesome.thermometer,
          size: 25,
          color: Colors.white,
        ),
        Text(data["Temperature"].toStringAsFixed(0) + "\u2103",
            style: TextStyle(
              color: Colors.white,
            ))
      ]);
    }

    getHumidityTextWidget() {
      return new Text("Humidity: " + data["Humidity"].toStringAsFixed(0) + "%",
          style: TextStyle(
            color: Colors.white,
          ));
    }

    List<Widget> getUnits() => [
          TableCell(
            child: Center(
                child: Center(
                    child: Text(
              "\u338D\\m\u00B3",
              style: TextStyle(color: Colors.grey, fontSize: 12.5),
            ))),
          ),
          TableCell(
            child: Center(
                child: Center(
                    child: Text(
              "\u338D\\m\u00B3",
              style: TextStyle(color: Colors.grey, fontSize: 12.5),
            ))),
          ),
          TableCell(
            child: Container(
                padding: EdgeInsets.only(top: 2), child: Center(child: null)),
          ),
          TableCell(
            child: Center(
                child: Text(
              "\u03C1\u03C1m",
              style: TextStyle(color: Colors.grey, fontSize: 12.5),
            )),
          ),
          TableCell(
            child: Center(child: null),
          ),
          TableCell(
            child: Center(
                child: Text(
              "\u338D\\m\u00B3",
              style: TextStyle(color: Colors.grey, fontSize: 12.5),
            )),
          ),
        ];

    List getAttributeValues() {
      List<Widget> list = List<Widget>();
      for (var a in data.keys) {
        if (a != "Temperature" && a != "Humidity") {
          list.add(TableCell(
              child: Center(
                  child: Text(
            (data[a]).toStringAsFixed(0),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    ScreenUtil().setSp(20.w.ssp, allowFontScalingSelf: true),
                color: helper.hexToColor(colorData[a])),
            maxLines: 1,
          ))));
        }
      }
      return list;
    }

    return Container(
        child: Column(children: <Widget>[
      Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 15, left: width * 7.5),
          child: Text(
            'My Monitor',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(20),
                color: Colors.grey[600],
                fontWeight: FontWeight.w600),
          )),
      Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(width * 5),
          child: Column(children: [
            Container(
                height: height * 30,
                decoration: BoxDecoration(
                    color: helper.hexToColor(colorData["AQI"]),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/waves1.png")),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(top: width * 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            BatteryWidget(),
                            Text(
                              this.deviceData["deviceId"],
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(15),
                                  color: Colors.white),
                            ),
                            Text(
                              this.deviceData["name"],
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(15),
                                  color: Colors.white),
                            )
                          ])),
                  Padding(
                      padding: EdgeInsets.only(top: width * 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Air is',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(18),
                                  color: Colors.white),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: width * 0.5),
                                child: Text(
                                  getAQIEquivalentString(data["AQI"])
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  maxLines: 1,
                                ))
                          ])),
                  Padding(
                    padding: EdgeInsets.only(
                        top: width * 2, left: width * 5, right: width * 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        getTemperatureTextWidget(),
                        getHumidityTextWidget(),
                      ],
                    ),
                  )
                ])),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(0, 3))
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: width * 3, left: width * 5, right: width * 5),
                      child: Table(
                        children: [
                          TableRow(children: getAttributeNames()),
                          TableRow(children: getAttributeValues()),
                          TableRow(children: getUnits()),
                        ],
                      )),
                  Padding(
                      padding:
                          EdgeInsets.only(top: width * 8, bottom: width * 5),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Updated $lastUpdated",
                            style: TextStyle(
                              color: lastUpdatedSeconds > 720
                                  ? Colors.red[200]
                                  : Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          )))
                ]))
          ])),
      Column(children: [
        Padding(
            padding: EdgeInsets.only(left: width * 7.5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Text(
                  'Radial Representation',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600),
                )))),
        RadialGraphs(data, colorData),
      ])
    ]));
  }
}
