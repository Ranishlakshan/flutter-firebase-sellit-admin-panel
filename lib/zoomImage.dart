import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ZoomImage extends StatefulWidget {

 final List<String> zoomlistOfImages;

 const ZoomImage({this.zoomlistOfImages});

  @override
  _ZoomImageState createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text("zoom"),
      //),
      body: PhotoViewGallery.builder(
        itemCount: widget.zoomlistOfImages.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
              widget.zoomlistOfImages[index],
            ),
            // Contained = the smallest possible size to fit one dimension of the screen
            minScale: PhotoViewComputedScale.contained * 0.8,
            // Covered = the smallest possible size to fit the whole screen
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          //color: Theme.of(context).canvasColor,
          color: Colors.black,
        ),
        // loadingChild: Center(
        //   child: CircularProgressIndicator(),
        // ),
      ),
    );
  }
}