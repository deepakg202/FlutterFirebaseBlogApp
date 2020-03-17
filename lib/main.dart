
import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:udgam/screens/root_screen.dart';
import 'package:udgam/services/authentication_service.dart';
import 'package:udgam/screens/about_screen.dart';
import 'package:udgam/screens/blog_screen.dart';
import 'package:udgam/screens/events_screen.dart';
import 'package:udgam/screens/gallery_screen.dart';
import 'package:udgam/screens/root_screen.dart';
import 'package:udgam/screens/sponsors_screen.dart';
import 'package:udgam/screens/teams_screen.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
       title: 'Udgam 2020',
        //theme: themeData.light(),
        //darkTheme: themeData.dark(),
        home: new Splash(),
      routes: {
       // RootPage.routeName: (context) => RootPage(),
        Events.routeName: (context) => Events(),
        Gallery.routeName: (context) => Gallery(),
        Teams.routeName: (context) => Teams(),
        Sponsors.routeName: (context) => Sponsors(),
        About.routeName: (context) => About(),
      },
    );
  }
}



class Splash extends StatelessWidget{

  final Map<int, Widget> op = {1: RootPage(auth: new Auth()), 2: RootPage(auth: new Auth())};

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomSplash(

          imagePath: 'assets/images/splash.png',
          backGroundColor: Colors.white,
          animationEffect: 'fade-in',
          logoSize: 250.0,
          home: op[2],
          // customFunction: duringSplash,
          duration: 2500,
          type: CustomSplashType.StaticDuration,
          outputAndHome: op,
        ),
        Align(
          child: LinearProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
          ),
          alignment: FractionalOffset.bottomCenter,
        ),
        Positioned(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
              child: Text(
                "Udgam'20",
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'IndieFlower',
                  color: Colors.black45,
                  fontSize: 65,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}






