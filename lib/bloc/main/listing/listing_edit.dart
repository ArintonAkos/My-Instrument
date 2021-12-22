import 'package:flutter/material.dart';

class ListingEditPage extends StatelessWidget {
  final String id;

  const ListingEditPage({
    Key? key,
    required this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
      )
    );
  }

}