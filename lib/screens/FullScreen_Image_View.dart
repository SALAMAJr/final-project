import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  FullScreenImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Image View'),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
