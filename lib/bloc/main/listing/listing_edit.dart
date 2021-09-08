import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListingEditPage extends StatelessWidget {
  final String id;

  ListingEditPage({
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
      )
    );
  }

}