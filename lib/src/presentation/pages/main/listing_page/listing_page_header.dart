import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/src/business_logic/blocs/listing_page/listing_page_bloc.dart';
import 'package:my_instrument/src/shared/theme/theme_methods.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

Widget buildHeaderText(BuildContext context, ListingPageState state) {
  if (state.isLoading) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      highlightColor: getCustomTheme(context)?.shimmerColor.withOpacity(0.1) ?? Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 20,
          width: 150,
          color: Colors.grey[300],
        ),
      )
    );
  }
  
  String titleText = '';
  if (state.isFailure) {
    titleText = AppLocalizations.of(context)!.translate('SHARED.ERROR.APPBAR_HEADER_TEXT');
  } else if (state.listing != null) {
    titleText = state.listing!.title;
  }
  
  return Text(
    titleText,
    style: TextStyle(
      color: Theme.of(context).colorScheme.onSurface
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}

PreferredSize listingPageHeader(BuildContext context, ListingPageState state) {
  return PreferredSize(
    child: ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.83),
          title: buildHeaderText(context, state),
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {
              AutoRouter.of(context).pop();
            },
          ),
          elevation: 0.0,
        ),
      ),
    ),
    preferredSize: const Size(
      double.infinity,
      56.0,
    ),
  );
}

