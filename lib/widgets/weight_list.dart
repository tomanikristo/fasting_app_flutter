import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/weight.dart';

class WeightList extends StatelessWidget {
  final List<Weight> weights;
  final Function deleteTx;

  WeightList(this.weights, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: weights.isEmpty
          ? Center(
              child: Text(
                'No weight added so far!',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                    elevation: 6,
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text(
                                '${weights[index].amount}kg',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          DateFormat.yMMMd().format(weights[index].date),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        // subtitle: Text(
                        //   DateFormat.yMMMd().format(weights[index].date),
                        // ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(weights[index].id),
                        )));
              },
              itemCount: weights.length,
            ),
    );
  }
}
