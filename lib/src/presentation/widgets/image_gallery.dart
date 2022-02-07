import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryImg extends StatefulWidget {

  final List<String> urlImages;

  const GalleryImg({Key? key,
    required this.urlImages
  }) : super(key: key);

  @override
  _GalleryImgState createState() => _GalleryImgState();
}


class _GalleryImgState extends State<GalleryImg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              PhotoViewGallery.builder(
                  itemCount: widget.urlImages.length,
                  builder: (context, index) {
                    final urlImage = widget.urlImages[index];

                    return PhotoViewGalleryPageOptions(
                      imageProvider: FileImage(File(urlImage)),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained * 4,
                    );
                  }
              ),
              Positioned(
                top: 40,
                left: 20,
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(60)
                  ),
                  child: IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.close),
                    color: Theme.of(context).colorScheme.onSurface,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ]
        )
    );
  }
}