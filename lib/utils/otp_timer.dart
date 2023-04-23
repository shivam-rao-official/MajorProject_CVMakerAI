import 'dart:async';

import 'package:flutter/material.dart';

class OtpTimer extends StatefulWidget {
  final int otpTimer;
  const OtpTimer({
    super.key,
    required this.otpTimer,
  });

  @override
  _OtpTimerState createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  int timeCounter = 00;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeCounter = 00;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("$timeCounter"),
    );
  }

  void startTimer() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        timeCounter += 1;
        setState(() {});
      },
    );
  }
}
