import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: GoogleFonts.robotoCondensed(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      onTap: tapHandler,
    );
  }

  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.red,
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            alignment: Alignment.bottomLeft,
            child: Text(
              'iFast',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'My Fasts',
            Icons.timelapse,
            () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          buildListTile('Settings', Icons.settings, () {})
        ],
      ),
    );
  }
}
