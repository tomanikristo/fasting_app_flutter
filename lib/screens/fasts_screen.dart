import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/fast.dart';
import '../widgets/new_fast_tab.dart';
import '../providers/fast_provider.dart';
import '../widgets/fast_list.dart';

class FastsScreen extends StatefulWidget {
  static const routeName = '/FastsScreen-screen';
  final int ftTime;

  FastsScreen({this.ftTime});
  @override
  _FastsScreen createState() => _FastsScreen(ftTime);
}

class _FastsScreen extends State<FastsScreen> {
  var isInit = true;
  var _isLoading = false;
  final int txHour;
  _FastsScreen(this.txHour);
  Future<void> _refreshFasts(BuildContext context) async {
    Provider.of<FastProvider>(context).fetchandSetFast();
  }

  @override
  void initState() {
    // Future.delayed(Duration.zero).then(
    //   (_) {
    //     Provider.of<FastProvider>(context).fetchandSetFast();
    //   },
    // );
    super.initState();
  }

  void didChangeDependencies() {
    if (isInit) {
      _isLoading = true;
      Provider.of<FastProvider>(context).fetchandSetFast().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void _addNewFast(
    String txTittle,
    int ftTime,
  ) {
    final fastData = Provider.of<FastProvider>(context);
    final fasts = fastData.officialFasts;
    final newTx = Fast(
      id: DateTime.now().toString(),
      title: txTittle,
      time: ftTime,
    );

    setState(() {
      fasts.add(newTx);
    });
    Navigator.of(context).pop();
  }

  void _startAddNewFast(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewFastTab(_addNewFast),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
            _startAddNewFast(context);
          });
          print(txHour);
        },
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshFasts(context),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : FastList(),
            ),
          ],
        ),
      ),
    );
  }
}
