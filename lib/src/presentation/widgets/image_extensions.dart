import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_instrument/src/data/data_providers/constants/image_constants.dart';
import 'package:octo_image/octo_image.dart';

ImageProvider<Object> getImageFromUrl(String? url, bool isPersonalDb) {
  if (url != null && url.isNotEmpty) {
    String defaultUrl = (isPersonalDb)
        ? ImageConstants.cloudStorageURL
        : '';
    return CachedNetworkImageProvider(
      defaultUrl + url
    );
  }

  return const AssetImage(
    'assets/no_image_placeholder.jpg'
  );
}

Widget getImage(String? imageUrl, String? imageHash, { bool? isPersonalDb }) {
  isPersonalDb ??= false;

  return OctoImage(
    image: getImageFromUrl(imageUrl, isPersonalDb),
    placeholderBuilder: (imageHash != null)
      ? OctoPlaceholder.blurHash(
        imageHash
      )
      : null,
    fit: BoxFit.cover,
    errorBuilder: OctoError.icon(),
  );
}