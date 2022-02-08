import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instrument/src/business_logic/blocs/product_list_page/product_list_page_bloc.dart';
import 'package:my_instrument/src/data/models/view_models/filter_data.dart';
import 'package:my_instrument/src/data/repositories/listing_repository.dart';
import 'package:my_instrument/src/presentation/pages/main/product_list_page/product_list_app_bar.dart';
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
            create: (context) => ProductListPageBloc(
              listingRepository: RepositoryProvider.of<ListingRepository>(context)
            )
            ..add(GetListings(
              request: GetListingsRequest(
                filterData: FilterData.initial()
              )
            )),
          ),
        ],
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (_, __) => [ ProductListAppBar(searchController: _searchController,) ],
          body: const ProductListBody(),
        ),
      )
    );
  }
}
