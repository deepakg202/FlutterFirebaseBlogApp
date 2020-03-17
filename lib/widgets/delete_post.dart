import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DeletePost extends StatelessWidget
{



  final String postKey;


  DeletePost(this.postKey);




  deletePostService() async{
    await FirebaseDatabase.instance.reference().child('posts/$postKey').remove();
    await FirebaseStorage.instance.ref().child('blogimg/$postKey.jpg').delete(); //Should use proper extension to image deletion
    
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build



    return AlertDialog(
      title: Text('Delete Post'),
      content: Text('Are You sure ?'),
        actions: <Widget>[
          MaterialButton(
            child: Text('Yes'),
            onPressed: () {
              deletePostService();
              Navigator.pop(context);
              },
          ),
          MaterialButton(
            elevation: 5.0,
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ]
    );

  }
}