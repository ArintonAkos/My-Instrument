import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

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
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Provider.of<ThemeNotifier>(context).getTheme()!.customTheme.exitButtonBackground,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: IconButton(
                        iconSize: 25,
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(CupertinoIcons.back),
                        color: Provider.of<ThemeNotifier>(context).getTheme()!.customTheme.exitButtonColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ]
        )
    );
  }
}