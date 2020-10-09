import 'package:frontend/JWT/token.dart';
import 'package:frontend/components/AQI/IntroductionView.dart';
import 'package:frontend/components/Login.dart';
import 'package:frontend/components/helper/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:frontend/components/HistoricalGraphs/HistoricalGraph.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/components/Loader.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  final Map deviceData;
  const HomePage(this.deviceData);
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  var data = {};
  var loading = true;
  var lastUpdatedSeconds;
  var colorData = {};
  Helper helper = new Helper();

  Future<Map> _getDeviceLatestData() async {
    final authToken = await Token().getToken();
    return await http.post("https://dashboard.airveda.com/api/data/latest/",
        body: {"deviceIds": widget.deviceData["deviceId"]},
        headers: {"Authorization": "Bearer $authToken"}).then((value) => value
                .statusCode ==
            200
        ? json.decode(value.body)[widget.deviceData["deviceId"]]
        : null);
  }

  Map _getDataUi(data) {
    Map<String, Map> retval = {"data": {}, "colorData": {}, "lastUpdated": {}};
    retval["lastUpdated"]["lastUpdated"] = DateTime.now()
        .difference(helper.convertUTCtoIST(DateTime.parse(data["lastUpdated"])))
        .inSeconds;
    data["data"].forEach((element) {
      retval["data"][element["label"].toString()] = element["value"];
      retval["colorData"][element["label"].toString()] = element["color"];
    });
    return retval;
  }

  @override
  void initState() {
    super.initState();
    if (!(data.keys.length > 0 || data.keys.length > 0)) {
      _getDeviceLatestData()
          .then((value) => _getDataUi(value))
          .then((value) => setState(() {
                data = value["data"];
                colorData = value["colorData"];
                lastUpdatedSeconds = value["lastUpdated"]["lastUpdated"];
                loading = false;
              }));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<CircularStackEntry> getPMRadialGraph() {
    List<CircularStackEntry> nextData = <CircularStackEntry>[];
    ["PM2.5", "PM10", "PM1"].forEach((element) {
      nextData.add(
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(data[element], Colors.red[200],
                rankKey: element),
            new CircularSegmentEntry(100, Colors.grey[300], rankKey: element),
          ],
          rankKey: 'PMS',
        ),
      );
    });
    return nextData;
  }

  refreshData() async {
    _getDeviceLatestData()
        .then((value) => _getDataUi(value))
        .then((value) => setState(() {
              data = value["data"];
              colorData = value["colorData"];
              lastUpdatedSeconds = value["lastUpdated"]["lastUpdated"];
            }));
    return [];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      theme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.green),
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(FlutterIcons.logout_ant),
                    onPressed: () async {
                      await Token().removeTokens();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Login()),
                          (r) => false);
                    },
                  ))
            ],
            title: Image.asset(
              'assets/logo/logo.png',
              width: 150,
              fit: BoxFit.cover,
            ),
            centerTitle: true,
          ),
          body: DefaultTabController(
              length: 2,
              child: data == null || data.keys.length == 0 || loading
                  ? Loader()
                  : Column(
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
                                Tab(
                                    icon: Icon(
                                  Icons.home,
                                )),
                                Tab(icon: Icon(Ionicons.md_analytics)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          color: Colors.blue[50],
                          child: TabBarView(children: [
                            RefreshIndicator(
                                onRefresh: () async => await refreshData(),
                                child: SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    child: IntroductionView(widget.deviceData,
                                        data, lastUpdatedSeconds, colorData))),
                            HistoricalGraph(widget.deviceData["deviceId"])
                          ]),
                        ))
                      ],
                    ))),
    );
  }
}
