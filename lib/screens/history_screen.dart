import 'package:flutter/material.dart';

import '../widgets/new_weight.dart';
import '../widgets/weight_list.dart';
import '../widgets/chart.dart';

import '../models/weight.dart';

class WeightScreen extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<WeightScreen> {
  final List<Weight> _userFasts = [];

  List<Weight> get _recentWeights {
    return _userFasts.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewWeigh(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Weight(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userFasts.add(newTx);
    });
  }

  void _startAddNewWeight(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewWeight(_addNewWeigh),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteWeight(String id) {
    setState(() {
      _userFasts.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Weight Tracker',
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentWeights),
            WeightList(_userFasts, _deleteWeight),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        child: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () => _startAddNewWeight(context),
      ),
    );
  }
}
