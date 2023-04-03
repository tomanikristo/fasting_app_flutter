import 'package:flutter/foundation.dart';

class Weight {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Weight({
    @required this.id,
    this.title,
    @required this.amount,
    @required this.date,
  });
}
