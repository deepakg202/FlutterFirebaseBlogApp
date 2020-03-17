import 'dart:ui';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:udgam/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:udgam/models/blog_data.dart';
import 'package:udgam/widgets/add_post_dialog.dart';
import 'package:udgam/services/authentication_service.dart';
import 'package:firebase_database/firebase_database.dart';



class Blog extends StatefulWidget {

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String email;
  final String name;
  static const String screenTitle = "Feed";

  Blog({Key key, this.auth, this.userId, this.logoutCallback, this.name, this.email})
      : super(key: key);

  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {

  FirebaseDatabase _database = FirebaseDatabase.instance;

  String postsNode = "posts";
  
  final _scrollController = new ScrollController();



  bool _scrollVisible;
  @override
  initState(){
    super.initState();
    _scrollVisible = false;
    _scrollController.addListener((){
      if(_scrollController.offset < 40){
        if(_scrollVisible == true) {
           setState(() {
             _scrollVisible = false;
           });
        }
      } else {
          if(_scrollVisible == false) {
             setState(() {
               _scrollVisible = true;
             });
        }
      }

    });
  }



  Widget build(BuildContext context) {


    return Scaffold(
      drawer: MainDrawer(name: widget.name, email: widget.email,),
      appBar: AppBar(

        textTheme: Theme.of(context).appBarTheme.textTheme,
        title: Text(Blog.screenTitle),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[

            Expanded(

              child: FirebaseAnimatedList(
                controller: _scrollController,
                sort: (a, b) => b.key.compareTo(a.key),
                defaultChild: Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(backgroundColor: Colors.black,),

                  ),
                ),

                query:
                    _database.reference().child(postsNode).orderByKey(),
                itemBuilder: (_, DataSnapshot snap, Animation<double> animation,
                    int index) {
                  return new BlogData(snap, widget.userId);
                  //End of returning all the posts
                },
              ),
         ),


          ],
        ),
      ),
      floatingActionButton: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[



            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Visibility(
                visible: _scrollVisible,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
           
           
                    });
                    _scrollController.animateTo(0, duration: new Duration(seconds: 1), curve: Curves.ease);
                  },
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.grey,
                  tooltip: 'Scroll to Top',
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Visibility(
                visible: true,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return AddPostDial(
                          name: widget.name,
                          uid: widget.userId,
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.grey,
                  tooltip: 'Add a Post',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

