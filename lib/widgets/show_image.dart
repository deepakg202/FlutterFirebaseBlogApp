import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowImage extends StatelessWidget {
  ShowImage({Key key, this.imageLink}) : super(key: key);

  final String imageLink;

  @override

  Widget build(BuildContext context) {


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
      ),
      body: Container(



        child: CachedNetworkImage(
          imageUrl: imageLink,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) => PhotoView(
            maxScale: PhotoViewComputedScale.contained * 4,
            minScale: PhotoViewComputedScale.contained,
            imageProvider: imageProvider,
            loadingBuilder: (context, event) => Container(
              color: Colors.black,
              child: Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
