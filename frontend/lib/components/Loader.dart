import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.blue[50]),
        child: Center(
          child: Lottie.asset('assets/loader.json'),
        ));
  }
}
