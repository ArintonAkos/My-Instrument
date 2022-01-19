import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instrument/src/data/models/view_models/filter_data.dart';
import 'package:my_instrument/src/presentation/pages/main/product_list_page/product_list_app_bar.dart';
import 'package:my_instrument/src/business_logic/blocs/listing_page/listing_page_bloc.dart';
import 'package:my_instrument/src/data/models/requests/main/listing/get_listings_request.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/listing_model.dart';
import 'package:my_instrument/src/presentation/pages/main/product_list_page/product_list_body.dart';

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
  late final TextEditingController _searchController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ListingPageBloc()
              ..add(GetListings(
                request: GetListingsRequest(
                  filterData: FilterData.initial()
                )
              )),
            ),
          ],
          child: CustomScrollView(
            slivers: [
              ProductListAppBar(searchController: _searchController,),
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
              const ProductListBody(),
            ]
          ),
        )
    );
  }
}
