import 'package:flutter/material.dart';

import '../screens/history_screen.dart';
import '../widgets/main_drawer.dart';
import './fasts_screen.dart';
import './progress_screen.dart';
import './history_screen.dart';

class TabScreen extends StatefulWidget {
  TabScreen({Key key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with WidgetsBindingObserver {
  final List<Map<String, Object>> _pages = [
    {
      'page': FastsScreen(),
      'title': 'Fasts',
    },
    {
      'page': ProgressScreen(),
      'title': 'Progress',
    },
    {
      'page': WeightScreen(),
      'title': 'History',
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text(_pages[_selectedPageIndex]['title'])),
        actions: <Widget>[],
      ),
      drawer: MainDrawer(),
      body: (_pages[_selectedPageIndex]['page']),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.red,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.playlist_add),
            title: Text(
              'Fast',
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.timelapse),
            title: Text(
              'Progress',
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.show_chart),
            title: Text(
              'Weight',
            ),
          ),
        ],
      ),
    );
  }
}
