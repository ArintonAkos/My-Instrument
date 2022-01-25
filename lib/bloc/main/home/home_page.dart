import 'package:flutter/material.dart';
import 'package:my_instrument/bloc/main/home/widgets/home_page_app_bar.dart';
import 'package:my_instrument/bloc/main/home/widgets/home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (_, __) => [ const HomePageAppBar() ],
      body: const HomePageBody()
    );
  }
}