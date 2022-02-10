import 'package:auto_route/auto_route.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/business_logic/blocs/product_list_page/product_list_page_bloc.dart';
import 'package:my_instrument/src/data/models/requests/main/listing/get_listings_request.dart';
import 'package:my_instrument/src/data/models/view_models/filter_data.dart';
import 'package:my_instrument/src/presentation/widgets/error_info.dart';
import 'package:my_instrument/src/presentation/widgets/image_extensions.dart';
import 'package:my_instrument/src/presentation/widgets/my_custom_refresh_indicator.dart';
import 'package:my_instrument/src/presentation/widgets/gradient_indeterminate_progress_bar.dart';
import 'package:my_instrument/src/business_logic/blocs/favorite/favorite_bloc.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/listing_model.dart';
import 'package:my_instrument/structure/route/router.gr.dart';
import 'package:octo_image/octo_image.dart';
import 'package:styled_widget/styled_widget.dart';

class ProductListBody extends StatelessWidget {
  const ProductListBody({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 400));

        context.read<ProductListPageBloc>().add(GetListings(
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
        child: BlocBuilder<ProductListPageBloc, ProductListPageState>(
          builder: (context, state) {
            switch (state.status) {
              case ListingPageStatus.failure:
                return const Center(
                  child: ErrorInfo()
                );
              case ListingPageStatus.success:
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
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
  final ProductListPageState listingPageState;

  const Listing({
    Key? key,
    required this.listing,
    required this.listingPageState
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        AutoRouter.of(context).push(ListingRoute(id: listing.listingId));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Hero(
          tag: 'listing-${listing.listingId}',
          child: Container(
            color: Theme.of(context).cardColor.withOpacity(0.85),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.6,
                  child: getImage(
                    listing.indexImagePath,
                    listing.indexImageHash,
                    isPersonalDb: true
                  )
                ),
                Card(
                  margin: EdgeInsets.zero,
                  color: Theme.of(context).cardColor,
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
                              color: Theme.of(context).colorScheme.onSurface,
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
                                  child: buildFavoriteButton(
                                    favoriteState,
                                    listing.listingId,
                                    const Icon(
                                      LineIcons.heart,
                                      key: ValueKey<int>(1),
                                    )
                                  )
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
          ),
        ),
      ),
    )
    .elevation(
      10.0,
      borderRadius: BorderRadius.circular(5),
      shadowColor: Theme.of(context).colorScheme.onBackground
    );
  }
}

Widget buildFavoriteButton(FavoriteState favoriteState, String listingId, Widget defaultIcon) {
  if (favoriteState is FavoriteLoadedState) {
    if (favoriteState.listingIds.contains(listingId)) {
      return const Icon(
        LineIcons.heartAlt,
        key: ValueKey<int>(0),
        color: Color(0xFFEF3534)
      );
    }
  }

  return defaultIcon;
}