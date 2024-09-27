import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/services.dart';

class ImageViewScreen extends StatelessWidget {
  final String imageUrl;

  ImageViewScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image View'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration: BoxDecoration(color: Colors.white),
        ),
      ),
    );
  }
}
