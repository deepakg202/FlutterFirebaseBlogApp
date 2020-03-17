import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:udgam/widgets/likes_button.dart';
import 'package:udgam/widgets/show_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:udgam/widgets/delete_post.dart';
import 'package:udgam/widgets/report_post.dart';


// ignore: must_be_immutable
class BlogData extends StatelessWidget {
  final DataSnapshot snapshot;
  final String uid;
  BlogData(this.snapshot, this.uid);

  bool delbutton = false;



  @override
  Widget build(BuildContext context) {


    if(snapshot.value['uid'] == uid || uid=='uOxH4Q83eCeTvefB0bPotheze4J3')
    {
      delbutton = true;
    }


    return new Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0, color: Colors.white),
              color: Colors.white),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
          child: Column(
            children: <Widget>[
              ListTile(
                subtitle: Text('College Name'),
                leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.account_circle)),
                title: Text('${snapshot.value['by']}',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: IconButton(
                  icon: delbutton?Icon(Icons.delete):Icon(Icons.report_problem),
                  onPressed: () {
                    showDialog(
                      context: context,

                      builder: (_) {
                        return delbutton?DeletePost(snapshot.key):ReportPost(snapshot.key, uid);
                      },
                    );
                  },
                )
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: snapshot.value['imglink'],
                    placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                    errorWidget: (context, url, error) => Container(child: Icon(Icons.error)),
                  ),
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return ShowImage(
                              imageLink: snapshot.value['imglink'],
                                  );
                        },
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                  child: Text(
                    snapshot.value['body'],
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  
                    new LikeButton(uid: uid, pid: snapshot.key),
                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Text(
                        DateFormat('dd MMM yyyy - KK:mm a')
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                snapshot.value['date']))
                            .toString(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
