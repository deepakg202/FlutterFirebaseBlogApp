import 'package:flutter/material.dart';
import 'package:udgam/widgets/main_drawer.dart';
import 'package:udgam/screens/blog_screen.dart';
import 'package:udgam/screens/about_screen.dart';
import 'package:udgam/screens/events_screen.dart';
import 'package:udgam/screens/gallery_screen.dart';
import 'package:udgam/screens/root_screen.dart';
import 'package:udgam/screens/sponsors_screen.dart';
import 'package:udgam/screens/teams_screen.dart';


class HomeScreen extends StatefulWidget {


  HomeScreen({Key key, @required this.page}) : super(key: key);
  final String page;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget _body;
  getWidget()
  {
    switch(widget.page)
    {
      case 'about':
        _body = About();
        break;
      case 'team':
        _body = Teams();
        break;
      case 'sponsor':
        _body = Sponsors();
        break;
    }
  }


  @override
  Widget build(BuildContext context) {

    getWidget();
    return Scaffold(




      //drawer: MainDrawer(),
    );
  }
}
