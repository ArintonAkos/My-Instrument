import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/src/presentation/widgets/page-transformer/page_transformer.dart';
import 'package:my_instrument/src/data/models/view_models/intro_item.dart';
import 'package:octo_image/octo_image.dart';

import '../../../data/models/view_models/intro_item.dart';

class IntroPageItem extends StatelessWidget {
  const IntroPageItem({
    Key? key,
    required this.item,
    required this.pageVisibility,
    this.onTap
  }) : super(key: key);

  final IntroItem item;
  final PageVisibility pageVisibility;
  final VoidCallback? onTap;

  Widget _applyTextEffects({
    required double translationFactor,
    required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  _buildTextContainer(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: Text(
        item.title,
        style: textTheme.caption!.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          item.title,
          style: textTheme.headline6!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Positioned(
      bottom: 56.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          categoryText,
          titleText,
        ],
      ),
    );
  }

  ImageProvider<Object> getImageFromUrl() {
    if (item.imageUrl != null) {
      return CachedNetworkImageProvider(
        item.imageUrl!
      );
    }

    return const AssetImage(
      'assets/no_image_placeholder.jpg'
    );
  }

  Widget getImage() {
    return OctoImage(
      image: getImageFromUrl(),
      placeholderBuilder: (item.imageHash != null)
        ? OctoPlaceholder.blurHash(
          item.imageHash!
        )
        : null,
      fit: BoxFit.cover,
      errorBuilder: OctoError.icon(),
    );
  }

  Widget imageOverlayGradient() {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Color(0xFF000000),
            Color(0x00000000),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(8.0),
                child: InkWell(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      getImage(),
                      imageOverlayGradient(),
                      _buildTextContainer(context),
                    ],
                  ),
                  onTap: onTap
                ),
            )
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {  },
              ),
            ),
          ),
        ]
      ),
    );
  }
}