import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/business_logic/blocs/favorite/favorite_bloc.dart';
import 'package:my_instrument/src/business_logic/blocs/listing_page/listing_page_bloc.dart';
import 'package:my_instrument/src/data/data_providers/constants/listing_constants.dart';
import 'package:my_instrument/src/presentation/pages/main/product_list_page/product_list_body.dart';
import 'package:my_instrument/src/shared/theme/theme_methods.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class ListingPageHeader extends StatelessWidget implements PreferredSizeWidget {

  final bool shouldShowAppBar;
  final String listingId;

  const ListingPageHeader({
    Key? key,
    required this.shouldShowAppBar,
    required this.listingId
  }) : super(key: key);

  Future<void> share(BuildContext context) async {
    await FlutterShare.share(
      title: AppLocalizations.of(context)!.translate('LISTING_PAGE.SHARE_LISTING_TITLE', fallbackText: 'Share listing'),
      linkUrl: ListingConstants.fullListingPathURL + listingId,
    );
  }

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

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: (shouldShowAppBar)
        ? Text(
          titleText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          key: const ValueKey<int>(0),
        )
        : Text(
          titleText,
          style: const TextStyle(
            color: Colors.white
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          key: const ValueKey<int>(1),
        ),
    );
  }

  Widget buildDefaultIcon(BuildContext context) {
    if (shouldShowAppBar) {
      return Icon(
        LineIcons.heart,
        key: const ValueKey<int>(1),
        color: Theme.of(context).colorScheme.onSurface
      );
    }

    return const Icon(
      LineIcons.heart,
      key: ValueKey<int>(2),
      color: Colors.white
    );
  }

  Widget buildShareIcon(BuildContext context) {
    if (shouldShowAppBar) {
      return Icon(
        LineIcons.shareSquare,
        key: const ValueKey<int>(0),
        color: Theme.of(context).colorScheme.onSurface
      );
    }

    return const Icon(
      LineIcons.shareSquare,
      key: ValueKey<int>(1),
      color: Colors.white
    );
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: ClipRRect(
        child: AppBar(
          toolbarOpacity: 1,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          flexibleSpace: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: (shouldShowAppBar)
                  ? BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Theme.of(context).colorScheme.surface,
                        Theme.of(context).colorScheme.surface
                      ],
                      stops: const <double>[
                        0,
                        1
                      ]
                  )
              )
                  : const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [
                        0,
                        1
                      ]
                  )
              )
          ),
          title: BlocBuilder<ListingPageBloc, ListingPageState>(
            builder: (context, state) => buildHeaderText(context, state)
          ),
          leading: InkWell(
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: (shouldShowAppBar)
                    ? Icon(
                    CupertinoIcons.back,
                    color: Theme.of(context).colorScheme.onSurface,
                    key: const ValueKey<int>(0)
                )
                    : const Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                    key: ValueKey<int>(1)
                )
            ),
            onTap: () {
              AutoRouter.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, favoriteState) => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: buildFavoriteButton(
                    favoriteState,
                    listingId,
                    buildDefaultIcon(context)
                  ),
                )
              ),
              onPressed: () {
                context.read<FavoriteBloc>().add(FavoriteClickEvent(listingId: listingId));
              }
            ),
            IconButton(
              icon: buildShareIcon(context),
              onPressed: () => share(context),
            ),
          ],
          elevation: 0.0,
        ),
      ),
      preferredSize: const Size(
        double.infinity,
        56.0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
