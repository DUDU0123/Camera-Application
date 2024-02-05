import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';

class ImageShowingPage extends StatelessWidget {
  const ImageShowingPage({super.key, required this.capturedImage});

  final String capturedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          await ImageGallerySaver.saveFile(capturedImage);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.black,
              duration: Duration(seconds: 2),
              content: Text(
                "Image Saved Successfully",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
        child: const Text("Save to Gallery"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   image: DecorationImage(image: FileImage(File(capturedImage))),
        // ),
        child: PhotoView(
          enableRotation: true,
          imageProvider: FileImage(File(capturedImage)),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
