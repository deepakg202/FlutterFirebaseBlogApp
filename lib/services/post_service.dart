import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';


class PostService {
  String postsNode = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;

  StorageReference _firebaseStorageRef;
  Map post;
  PostService(this.post);

  uploadData(_image, postname, k) async {
    _databaseReference = database.reference().child(postsNode);
    _firebaseStorageRef =
        FirebaseStorage.instance.ref().child('blogimg/${postname + '.' + k}');
    StorageUploadTask uploadTask = _firebaseStorageRef.putFile(_image);

    var downurl =  await (await uploadTask.onComplete).ref.getDownloadURL();
    String url = downurl.toString();

    post['imglink'] = url;
    await _databaseReference.child(postname).set(post);


  }


}
