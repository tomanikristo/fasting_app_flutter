import 'package:flutter/material.dart';
import 'package:ifast/screens/progress_screen.dart';

import './screens/tabs.screen.dart';

import './screens/fasts_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import './screens/fast_config_screen.dart';
import './providers/fast_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => FastProvider(),
      child: MaterialApp(
        title: 'Fasts',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.red,
          textTheme: GoogleFonts.ralewayTextTheme().copyWith(
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 20
            ),
            bodyText1: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
            headline4: TextStyle(
              fontSize: 5,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            headline5: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
            headline6: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        // home: CategoriesScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabScreen(),
          ConfigFastScreen.routeName: (ctx) => ConfigFastScreen(),
          FastsScreen.routeName: (ctx) => FastsScreen(),
          ProgressScreen.routeName: (ctx) => ProgressScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => FastsScreen(),
          );
        },
      ),
    );
  }
}


