import 'package:flutter/material.dart';
import '../screens/fast_config_screen.dart';
import 'package:provider/provider.dart';
import '../providers/fast.dart';

class FastItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final int time;
  // final Color color;
  // bool isActive;

  // FastItem(this.id, this.time, this.title, this.color, this.isActive);

  @override
  Widget build(BuildContext context) {
    final fastData = Provider.of<Fast>(context, listen: false);

    void selectCagegory(BuildContext ctx) {
      Navigator.of(ctx)
          .pushNamed(ConfigFastScreen.routeName, arguments: fastData.id);
    }

    return InkWell(
      onTap: () => selectCagegory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(50),
        child: Consumer<Fast>(
          builder: (ctx, fast, _) => Column(
            children: <Widget>[
              Text(
                fastData.title,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              Text(
                '${fastData.time} hours fasting',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                fastData.isActive ? 'Active' : '',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              fastData.color.withOpacity(0.75),
              fastData.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
