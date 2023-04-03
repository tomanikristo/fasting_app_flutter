import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/fast_provider.dart';

class ConfigFastScreen extends StatefulWidget {
  static const routeName = '/ConfigFastScreen-screen';

  @override
  _ConfigFastScreenState createState() => _ConfigFastScreenState();
}

class _ConfigFastScreenState extends State<ConfigFastScreen> {
  void _saveAsActiveFast() {
    final fastID = ModalRoute.of(context).settings.arguments as String;
    final _fastprovider =
        Provider.of<FastProvider>(context, listen: false).findById(fastID);
    _fastprovider.activeID = _fastprovider.id;
    _fastprovider.activeTime = _fastprovider.time;
    _fastprovider.activeTitle = _fastprovider.title;

    print(_fastprovider.activeID);
    print(_fastprovider.activeFastStartTime);
    print(_fastprovider.activeTime);
  }

  @override
  Widget build(BuildContext context) {
    final fastID = ModalRoute.of(context).settings.arguments as String;
    final _fastprovider = Provider.of<FastProvider>(context).findById(fastID);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.red,
          size: 35,
        ),
        onPressed: () {
          setState(() {
            _fastprovider.toggleActiveFast(_fastprovider);
            Navigator.pop(context);
            _saveAsActiveFast();
          });
        },
      ),
      appBar: AppBar(
        title: Text(
          'Set-Up',
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              ('${_fastprovider.title}'),
            ),
          ],
        ),
      ),
    );
  }
}
