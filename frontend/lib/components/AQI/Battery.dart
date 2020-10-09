import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_indicator/battery_indicator.dart';
import 'package:battery/battery.dart';
import 'package:flutter/widgets.dart';

class BatteryWidget extends StatefulWidget {
  BatteryWidget({Key key}) : super(key: key);
  @override
  _Battery createState() => new _Battery();
}

class _Battery extends State<BatteryWidget> {
  Battery battery;
  var _charging = false;
  StreamSubscription<BatteryState> _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    battery = new Battery();
    _batteryStateSubscription = battery.onBatteryStateChanged.listen((onData) {
      setState(() {
        _charging = onData == BatteryState.charging;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 100;

    return Stack(
      children: <Widget>[
        new BatteryIndicator(
          style: BatteryIndicatorStyle.values[1],
          colorful: true,
          showPercentNum: false,
          mainColor: Colors.black,
          size: width * 2.5,
          ratio: 2.5,
          showPercentSlide: true,
        ),
        if (_charging)
          Padding(
            padding: EdgeInsets.only(left: width * 1.8),
            child: Icon(
              Icons.power,
              size: width * 2.5,
            ),
          )
      ],
    );
  }

  @override
  void dispose() {
    _batteryStateSubscription.cancel();
    super.dispose();
  }
}
