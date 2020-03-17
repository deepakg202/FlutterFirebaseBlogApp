import 'package:firebase_database/firebase_database.dart';

class Post {
  static const KEY = "key";
  static const DATE = "date";
  static const BODY = "body";
  static const BY = "by";
  static const UID = "uid";
  static const IMGLINK = "imglink";


  int date;
  String key;
  String body;
  String by;
  String uid;
  String imglink;

  Post(this.date, this.body, this.by, this.uid, this.imglink);

  Post.fromSnapshot(DataSnapshot snap)
      : this.key = snap.key,
        this.body = snap.value[BODY],
        this.date = snap.value[DATE],
        this.by = snap.value[BY],
        this.uid = snap.value[UID],
        this.imglink = snap.value[IMGLINK];


  Map toMap() {
    return {KEY: key, BODY: body, DATE: date, BY: by, UID: uid, IMGLINK: imglink};
  }
}


