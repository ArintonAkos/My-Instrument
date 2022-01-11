import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/bloc/main/product_list/filter_data.dart';
import 'package:my_instrument/structure/route/router.gr.dart';

import 'home_header.dart';

class HomePageAppBar extends StatefulWidget {
  const HomePageAppBar({Key? key}) : super(key: key);

  @override
  _HomePageAppBarState createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {

  final TextEditingController _searchController = TextEditingController();

  _onSearchSubmitted(String searchValue) {
    if (searchValue.isNotEmpty) {
      _searchController.clear();

      AutoRouter.of(context).push(
        ProductListRoute(
          filterData: FilterData.initial(
            search: searchValue,
          )
      ));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      collapsedHeight: 80,
      backgroundColor: Theme.of(context).backgroundColor,
      flexibleSpace: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: HomeHeader(
            onSubmitted: _onSearchSubmitted,
            searchController: _searchController,
          )
      ),
      floating: true,
    );
  }
}