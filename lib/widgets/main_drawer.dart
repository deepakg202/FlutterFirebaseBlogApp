import 'package:flutter/material.dart';
import 'package:udgam/screens/about_screen.dart';
import 'package:udgam/screens/events_screen.dart';
import 'package:udgam/screens/gallery_screen.dart';
import 'package:udgam/screens/root_screen.dart';
import 'package:udgam/screens/sponsors_screen.dart';
import 'package:udgam/screens/teams_screen.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key key, this.uid = '', this.name = '', this.email = ''})
      : super(key: key);

  final String uid;
  final String name;
  final String email;

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            child: UserAccountsDrawerHeader(
              accountName: Text(
                name,
                style: Theme.of(context).textTheme.title,
              ),
              accountEmail: Text(
                email,
                style: Theme.of(context).textTheme.caption,
              ),
              currentAccountPicture: CircleAvatar(
                minRadius: 20,
                maxRadius: 40,
                child: Text(
                  "A",
                  style: Theme.of(context).textTheme.title,
                ),
                backgroundColor: Theme.of(context).appBarTheme.color,
              ),
            ),
          ),
          // buildListTile(context, "Feed", Icons.chrome_reader_mode, () {
          //   Navigator.of(context).pushReplacementNamed(RootPage.routeName);
          // }),
          buildListTile(context, "Events", Icons.event, () {
            Navigator.of(context).pushReplacementNamed(Events.routeName);
          }),
          buildListTile(context, "Gallery", Icons.photo, () {
            Navigator.of(context).pushReplacementNamed(Gallery.routeName);
          }),
          buildListTile(context, "Teams", Icons.people, () {
            Navigator.of(context).pushReplacementNamed(Teams.routeName);
          }),
          buildListTile(context, "Sponsors", Icons.attach_money, () {
            Navigator.of(context).pushReplacementNamed(Sponsors.routeName);
          }),
          buildListTile(context, "About", Icons.info, () {
            Navigator.of(context).pushReplacementNamed(About.routeName);
          }),
        ],
      ),
    );
  }

  ListTile buildListTile(
      BuildContext context, String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
        size: Theme.of(context).iconTheme.size,
      ),
      title: Text(title, style: Theme.of(context).textTheme.subtitle),
      onTap: tapHandler,
    );
  }
}
