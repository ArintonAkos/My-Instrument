import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/shared/theme/theme_methods.dart';
import 'package:my_instrument/src/presentation/widgets/gradient_indeterminate_progress_bar.dart';
import 'package:my_instrument/src/business_logic/blocs/favorite/favorite_bloc.dart';
import 'package:my_instrument/src/business_logic/blocs/listing_page/listing_page_bloc.dart';
import 'package:my_instrument/src/data/data_providers/constants/image_constants.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/listing_model.dart';

class ProductListBody extends StatelessWidget {
  const ProductListBody({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingPageBloc, ListingPageState>(
      builder: (context, state) {
        switch (state.status) {
          case ListingPageStatus.failure:
            return SliverToBoxAdapter(
              // TODO: Change this defaultLoader to StreamBuilder or BlocBuilder
              // child: DefaultFallback()
              child: Container(),
            );
          case ListingPageStatus.success:
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: CustomRefreshIndicator(
                  builder: (BuildContext context, Widget child, IndicatorController controller) =>
                      AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, _) =>
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                if (!controller.isIdle)
                                  Positioned(
                                    top: 35.0 * controller.value,
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        value: !controller.isLoading
                                            ? controller.value.clamp(0.0, 1.0)
                                            : null,
                                        color: getCustomTheme(context)?.loginButtonText,
                                      ),
                                    ),
                                  ),
                                Transform.translate(
                                  offset: Offset(0, 100.0 * controller.value),
                                  child: child,
                                ),
                              ],
                            ),
                      ),
                  onRefresh: () => Future.delayed(const Duration(seconds: 3)),
                  child: MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemCount: state.listings.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Listing(listing: state.listings[index], listingPageState: state,)
                  ),
                )
              ),
            );
          default:
            return const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: GradientIndeterminateProgressbar(
                  width: 50,
                  height: 50,
                ),
              ),
            );
        }
      }
    );
  }
}

class Listing extends StatelessWidget {
  final ListingModel listing;
  final ListingPageState listingPageState;

  const Listing({
    Key? key,
    required this.listing,
    required this.listingPageState
  }) : super(key: key);

  Widget buildFavoriteButton(FavoriteState favoriteState, ListingPageState state) {
    if (favoriteState is FavoriteLoadedState) {
      if (favoriteState.listingIds.contains(listing.listingId)) {
        return const Icon(
            LineIcons.heartAlt,
            key: ValueKey<int>(0),
            color: Color(0xFFEF3534)
        );
      }
    }

    return const Icon(
      LineIcons.heart,
      key: ValueKey<int>(1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.6,
            child: BlurHash(
                imageFit: BoxFit.cover,
                image: ImageConstants.cloudStorageURL + listing.indexImagePath,
                hash: listing.indexImageHash
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Instruments/Guitars/Electric-Guitars',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          fontSize: 12
                      ),
                    ),
                  ),
                  Row(
                      children: [
                        Expanded(
                          child: Text(
                              listing.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18
                              )
                          ),
                        ),
                        BlocBuilder<FavoriteBloc, FavoriteState>(
                            builder: (context, favoriteState) => IconButton(
                              icon: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child,),
                                  child: buildFavoriteButton(favoriteState, listingPageState)
                              ),
                              onPressed: () {
                                context.read<FavoriteBloc>().add(FavoriteClickEvent(listingId: listing.listingId));
                              },
                            )
                        )
                      ]
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        '${listing.price} lei',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        )
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Stock: 2',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}