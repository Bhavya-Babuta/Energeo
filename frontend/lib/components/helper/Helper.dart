import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  bool checkDateEqual(DateTime date1, DateTime date2) =>
      date1.compareTo(date2) == 0;

  DateTime convertUTCtoIST(DateTime date) =>
      date.add(Duration(hours: 5, minutes: 30));

  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  Map<String, String> getAverageValueColor(attribute, value) {
    if (value == null) {
      return {"color": "#000000", "text": "NA"};
    }
    value = double.parse(value);
    switch (attribute) {
      case 'ikw/tr':
        if (value > 0.0 && value <= 0.55) {
          return {"color": "#17AF35", "text": "Good"};
        } else if (value >= 0.55 && value <= 0.65) {
          return {"color": "#74CB40", "text": "Fair"};
        } else if (value >= 0.66) {
          return {"color": "#A60505", "text": "Severe"};
        }
        return {"color": "#000000", "text": "NA"};
      case "pm2.5":
        if (value > 0.0 && value <= 30.0) {
          return {"color": "#17AF35", "text": "Good"};
        } else if (value >= 31.0 && value <= 60.0) {
          return {"color": "#74CB40", "text": "Satisfactory"};
        } else if (value >= 61.0 && value <= 90.0) {
          return {"color": "#E1CB43", "text": "Moderate"};
        } else if (value >= 91.0 && value <= 120.0) {
          return {"color": "#E08638", "text": "Poor"};
        } else if (value >= 121.0 && value <= 250.0) {
          return {"color": "#CE2121", "text": "Very Poor"};
        } else if (value >= 251.0) {
          return {"color": "#A60505", "text": "Severe"};
        }
        return {"color": "#000000", "text": "NA"};
      case "pm10":
        if (value > 0.0 && value <= 50.0) {
          return {"color": "#17AF35", "text": "Good"};
        } else if (value >= 51.0 && value <= 100.0) {
          return {"color": "#74CB40", "text": "Satisfactory"};
        } else if (value >= 101.0 && value <= 250.0) {
          return {"color": "#E1CB43", "text": "Moderate"};
        } else if (value >= 251.0 && value <= 350.0) {
          return {"color": "#E08638", "text": "Poor"};
        } else if (value >= 351.0 && value <= 430.0) {
          return {"color": "#CE2121", "text": "Very Poor"};
        } else if (value >= 430.0) {
          return {"color": "#A60505", "text": "Severe"};
        }
        return {"color": "#000000", "text": "NA"};
      case "co2":
        if (value > 0.0 && value <= 750.0) {
          return {"color": "#17AF35", "text": "Good"};
        } else if (value >= 751.0 && value <= 900.0) {
          return {"color": "#74CB40", "text": "Satisfactory"};
        } else if (value >= 901.0 && value <= 1100.0) {
          return {"color": "#E1CB43", "text": "Moderate"};
        } else if (value >= 1101.0 && value <= 1400.0) {
          return {"colo": "#E08638", "text": "Poor"};
        } else if (value >= 1401.0 && value <= 2500.0) {
          return {"color": "#CE2121", "text": "Very Poor"};
        } else if (value >= 2501.0) {
          return {"color": "#A60505", "text": "Severe"};
        }
        return {"color": "#000000", "text": "NA"};
      case "aqi":
        if (value > 0.0 && value <= 50.0) {
          return {"color": "#17AF35", "text": "Good"};
        } else if (value >= 51.0 && value <= 100.0) {
          return {"color": "#74CB40", "text": "Satisfactory"};
        } else if (value >= 101.0 && value <= 200.0) {
          return {"color": "#E1CB43", "text": "Moderate"};
        } else if (value >= 201.0 && value <= 300.0) {
          return {"colo": "#E08638", "text": "Poor"};
        } else if (value >= 301.0 && value <= 400.0) {
          return {"color": "#CE2121", "text": "Very Poor"};
        } else if (value >= 401.0 && value <= 500.0) {
          return {"color": "#A60505", "text": "Severe"};
        }
        return {"color": "#000000", "text": "NA"};
      case "voc":
        if (value > 0.0 && value <= 219.0) {
          return {"color": "#17AF35", "text": "Good"};
        } else if (value >= 220.0 && value <= 324.0) {
          return {"color": "#74CB40", "text": "Satisfactory"};
        } else if (value >= 325.0 && value <= 500.0) {
          return {"color": "#E1CB43", "text": "Moderate"};
        } else if (value >= 501.0) {
          return {"color": "#A60505", "text": "Severe"};
        }
        return {"color": "#000000", "text": "NA"};
      case "temperature":
        if (value > 0.0 && value <= 17.0) {
          return {"color": "#17AF35", "text": "Good"};
        } else if (value >= 18.0 && value <= 27.0) {
          return {"color": "#74CB40", "text": "Satisfactory"};
        } else if (value >= 28.0 && value <= 50.0) {
          return {"color": "#E1CB43", "text": "Moderate"};
        } else if (value >= 501.0) {
          return {"color": "#A60505", "text": "Severe"};
        }
        return {"color": "#000000", "text": "NA"};
      case "humidity":
        if (value > 0.0 && value <= 29.0) {
          return {"color": "#74CB40", "text": "Satisfactory"};
        } else if (value >= 30.0 && value <= 60.0) {
          return {"color": "#E1CB43", "text": "Moderate"};
        } else if (value >= 61.0) {
          return {"color": "#A60505", "text": "Severe"};
        }
        return {"color": "#000000", "text": "NA"};
      default:
        return {"color": "#000000", "text": "NA"};
    }
  }

  String getStartDateText(startDate) => checkDateEqual(
          startDate,
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day))
      ? "Today"
      : DateFormat("MMMM d, y").format(startDate).toString();

  List<String> getTopRowAttributeButtons(controllerTye) {
    switch (controllerTye) {
      case 1:
        return ["aqi", "pm2.5", "pm10", "pm1"];
      case 2:
        return ["ikw/tr", "tr", "trh", "power_meter"];
      default:
        return [];
    }
  }

  List<String> getBottomRowAttributeButtons(controllerTye) {
    switch (controllerTye) {
      case 1:
        return ["temperature", "humidity", "voc", "co2"];
      case 2:
        return ["water_flow", "cdw\u0394T & chw\u0394T"];
      default:
        return [];
    }
  }
}
