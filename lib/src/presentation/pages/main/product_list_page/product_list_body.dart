import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/data/models/requests/main/listing/get_listings_request.dart';
import 'package:my_instrument/src/data/models/view_models/filter_data.dart';
import 'package:my_instrument/src/presentation/pages/base/error_page.dart';
import 'package:my_instrument/src/presentation/widgets/error_info.dart';
import 'package:my_instrument/src/presentation/widgets/my_custom_refresh_indicator.dart';
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
    return CustomRefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 400));

        context.read<ListingPageBloc>().add(GetListings(
          request: GetListingsRequest(
            filterData: FilterData.initial()
          )
        ));
      },
      builder: (BuildContext context, Widget child, IndicatorController controller) => MyCustomRefreshIndicator(
        controller: controller,
        child: child
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<ListingPageBloc, ListingPageState>(
          builder: (context, state) {
            switch (state.status) {
              case ListingPageStatus.failure:
                return const Center(
                  child: ErrorInfo()
                );
              case ListingPageStatus.success:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                );
              default:
                return const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: GradientIndeterminateProgressbar(
                    width: 50,
                    height: 50,
                  ),
                );
            }
          }
        ),
      ),
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