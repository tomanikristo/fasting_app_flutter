import 'package:flutter/material.dart';

class Fast with ChangeNotifier {
  final String id;
  String activeID;
  final String title;
  String activeTitle;
  final int time;
  int activeTime;
  final TimeOfDay fastStartTime;
  TimeOfDay activeFastStartTime;
  final Color color;
  bool isActive;

  Fast(
      {this.id,
      @required this.title,
      @required this.time,
      this.color = Colors.red,
      this.isActive,
      this.fastStartTime,
      this.activeID,
      this.activeFastStartTime,
      this.activeTime,
      this.activeTitle});

  void toggleActiveFast(Fast fast) {
    if (fast.id == id) {
      isActive = !isActive;
    } else
      isActive = false;

    notifyListeners();
  }

 
}
