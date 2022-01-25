import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/bloc/main/home/widgets/search_field.dart';
import 'package:my_instrument/services/main/listing/listing_service.dart';
import 'package:my_instrument/services/models/requests/main/listing/get_listings_request.dart';
import 'package:my_instrument/services/models/responses/main/listing/get_listings_response.dart';
import 'package:my_instrument/services/models/responses/main/listing/listing_model.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';

import 'filter_data.dart';

class ProductListPage extends StatefulWidget {
  final FilterData filterData;

  const ProductListPage({
    Key? key,
    required this.filterData
  }) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  final ListingService _listingService = appInjector.get<ListingService>();
  late final TextEditingController _searchController;
  final FilterData _filterModel = FilterData(search: '', categories: [], filters: <int, List<int>>{});

  // Stream<List<ListingModel>> listingsStream = ;
  Future<List<ListingModel>>? listings;
  int page = 1;

  @override
  void initState() {
    _searchController = TextEditingController(text: widget.filterData.search);
    _searchController.addListener(onSearchTextChange);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  onSearchTextChange() {
    // fetch new data from DB
    // await ()
  }

  void updateListings() {
    listings = getListings();
    setState(() {});
  }

  Future<List<ListingModel>> getListings() async {
    var res = await _listingService.getListings(GetListingsRequest(
      search: _filterModel.search,
      categories: _filterModel.categories,
      filters: _filterModel.filters,
      page: page
    ));

    if (res.ok) {
      return (res as GetListingsResponse).listings;
    }

    throw Exception("Couldn't fetch data!");
  }

  Widget appBarItem({
    required Function() onPressed,
    required String text,
    required IconData iconData
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            iconData,
            size: 24,
            color: Theme.of(context).colorScheme.onSurface
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface
              ),
            ),
          )
        ],
      ),
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF979797).withOpacity(0.1),
        primary: Colors.black12,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: 110 + MediaQuery.of(context).padding.top,
            backgroundColor: Theme.of(context).backgroundColor,
            automaticallyImplyLeading: false,
            floating: true,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(top: 10 + MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.back
                        ),
                        onPressed: () => AutoRouter.of(context).pop(),
                        splashRadius: 25,
                      ),
                      SearchField(
                        width: MediaQuery.of(context).size.width - 80,
                        controller: _searchController,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Row(
                      children: [
                        appBarItem(
                          onPressed: () {},
                          text: 'Filters',
                          iconData: LineIcons.filter
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: appBarItem(
                            onPressed: () {},
                            text: 'Order By',
                            iconData: LineIcons.sortAmountUp
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          /*SliverToBoxAdapter(
            child: DefaultLoader<List<ListingModel>>(
              future: listings,
              builder: (BuildContext context) => SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0,
                ),
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) =>
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: [
                        BlurHash(
                          imageFit: BoxFit.cover,
                          image: listings[index].indexImagePath,
                          hash: listings[index].indexImageHash
                        ),
                        Card(
                          color: Theme.of(context).colorScheme.surface,
                          child: Text(
                            listings[index].description
                          ),
                        )
                      ],
                    ),
                  ),
                  childCount: listings?.length,
                ),
              ),
            ),
          ),*/
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: Text('grid item $index'),
              ),
              childCount: 30,
            ),
          )
        ]
      )
    );
  }
}
