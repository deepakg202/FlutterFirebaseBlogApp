import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LikeButton extends StatefulWidget
{
  @override

  LikeButton({Key key, this.pid, this.uid}) : super(key: key);

  final String pid;
  final String uid;
  _LikeButtonState createState() => new _LikeButtonState();

}

class _LikeButtonState extends State<LikeButton>{
  
  
  bool _liked = false;
  int _likes = 0;

  Map _likers;


  addLike() async{
    await FirebaseDatabase.instance.reference().child('posts/${widget.pid}/likers/').update({widget.uid : true});
  }

  removeLike() async{
    await FirebaseDatabase.instance.reference().child('posts/${widget.pid}/likers/${widget.uid}').remove();
    
  }



  getLikestatus() async{
      bool stat = (await FirebaseDatabase.instance.reference().child('posts/${widget.pid}/likers/${widget.uid}').once()).value;
    
      if(stat==true)
      {
        setState(() {
          _liked = true;
        });
      }else{
        setState(() {
          _liked = false;
        });
      }
    }


    likenos() async {
      var nos = (await FirebaseDatabase.instance.reference().child('posts/${widget.pid}/likers/').once());
    
      setState(() {
        if(nos.value == null)
        {
          _likers = null;
          _likes = 0;
        }
        else{
          _likers = nos.value;
          _likes = nos.value.length;
        }
       
      });
    }

  
  void initState()
  {
    super.initState();
    
    getLikestatus();
    likenos();
  
  }

  @override
  Widget build(BuildContext context) {
      // TODO: implement build
    
    return Row(
      children: <Widget>[
        IconButton(
          
          icon: _liked?Icon(Icons.favorite, color: Colors.red):Icon(Icons.favorite_border, color: Colors.red),
          onPressed: () {
            

            if(_liked == false)
              addLike();
            else
              removeLike();
      

            getLikestatus();
            likenos();
            

          },
        ),

        RaisedButton(
          child: Text(_likes.toString()),
          onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new LikesDialog(_likers)),
              );
          },
        ),
      ],
    );
  }


}



class LikesDialog extends StatefulWidget
{
  final Map likers;
  LikesDialog(this.likers);

  @override
  _LikesDialogState createState() => _LikesDialogState();
}

class _LikesDialogState extends State<LikesDialog> {
  
  Widget build(BuildContext context){
    
    return Scaffold(
      appBar: AppBar(title: Text('Likes'),),
      body: widget.likers==null?Center(child: Text('No Likes Yet')):ListView.builder(
        itemCount: widget.likers.length,
        itemBuilder: (context, index) {
          String ukey = widget.likers.keys.elementAt(index);
             return ListTile(
              leading: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.account_circle)
                    ),
              title: LikerName(ukey),
            );
          },
        )
    );

  }
}




class LikerName extends StatefulWidget
{
  String ukey;
  LikerName(this.ukey);

  @override
  _LikerNameState createState() => _LikerNameState();
}

class _LikerNameState extends State<LikerName> {
  String _name = '';

  getNamefromkey() async
  {
    String temp = (await FirebaseDatabase.instance.reference().child('users/${widget.ukey}/Name').once()).value;
    setState(() {
      _name = temp;  
    });
  }

  void initState()
  {
    super.initState();
    getNamefromkey();
  }

  Widget build(BuildContext context)
  {
    return Text(_name);
  }
}