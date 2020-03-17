import 'package:flutter/material.dart';
import 'package:udgam/screens/login_signup_screen.dart';
import 'package:udgam/services/authentication_service.dart';
import 'package:udgam/screens/blog_screen.dart';
import 'package:firebase_database/firebase_database.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  static const routeName = '/root_screen';

  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  String _name='';
  String _email='';



  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });

    }



  void loginCallback() {
   
    
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
        //_name = user; 
      });
    });
    
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
   //   _userdata = null;
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }


  void getDetails(uId) async
  {
    await FirebaseDatabase.instance.reference().child('users/$uId').once().then((val) {
      setState(() {

        _name = val.value['Name'];
        _email = val.value['Email'];

      });
    });
  }



  @override

  Widget build(BuildContext context) {

    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignUpPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {

          getDetails(_userId);

          return Blog(
            userId: _userId,
            auth: widget.auth,
            name: _name,
            email: _email,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}