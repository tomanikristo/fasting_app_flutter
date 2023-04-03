import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/fast_provider.dart';

import './fast_Item.dart';

class FastList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fastData = Provider.of<FastProvider>(context);
    final fasts = fastData.officialFasts;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: fasts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: fasts[i],
        child: FastItem(),
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
