import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class ReportPost extends StatefulWidget
{

  final String postKey;
  final String uid;

  ReportPost(this.postKey, this.uid);

  @override
  _ReportPostState createState() => _ReportPostState();
}

class _ReportPostState extends State<ReportPost> {
  String reason = '';

final GlobalKey<FormState> reportkey = new GlobalKey();

  ReportPostService() async{
    final FormState form = reportkey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      await FirebaseDatabase.instance.reference().child('reports/${widget.postKey}').update({widget.uid:reason});
      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build



    return AlertDialog(
      
      title: Text('Report Post'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Why would you ?\n'),
          Form(
           key: reportkey,
           child: TextFormField(
              
              maxLength: 150,
              minLines: 2,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Write your reason',
                hintText: 'Better be good',
                border: OutlineInputBorder(),
                //contentPadding: new EdgeInsets.symmetric(),
              ),
                        validator: (value){
                          if(value.isEmpty)
                            return 'Your Reason is required';
                          else if(widget.uid == "")
                            return 'Unknown Error Occured. Please Try Again';
                          },
                        onSaved: (val) => reason = val.trim(),
                      ),
          ),
        ],
      ),
        actions: <Widget>[
          MaterialButton(
            child: Text('Yes'),
            onPressed: () {

              ReportPostService();  
              
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