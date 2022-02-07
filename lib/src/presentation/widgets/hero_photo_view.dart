import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HeroPhotoView extends StatelessWidget {
  const HeroPhotoView({
    Key? key,
    required this.imageProvider,
    this.backgroundDecoration,
    required this.heroTag,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return  Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        backgroundDecoration: backgroundDecoration,
        heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
      ),
    );
  }
}
