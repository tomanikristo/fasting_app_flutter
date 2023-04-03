import 'package:flutter/material.dart';

class ActiveFast with ChangeNotifier {
  String activeID;
  String title;
  int time;
  TimeOfDay fastStartTime;
  Color color;
  bool isActive;

  ActiveFast({
    @required this.activeID,
    @required this.title,
    @required this.time,
    this.color = Colors.red,
    this.isActive,
    this.fastStartTime,
  });

  void toggleActiveFast() {
    isActive = !isActive;
  }
}
