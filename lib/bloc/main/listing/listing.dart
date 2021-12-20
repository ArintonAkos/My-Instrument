import 'package:flutter/material.dart';

class ListingPage extends StatelessWidget {
  final String id;

  const ListingPage({
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.red,
        height: (MediaQuery.of(context).size.height
        ),
        child: Material(
          child: TextButton(
            onPressed: () {
              // Modular.to.pushNamed('/listing/23');
            },
            child: Text('asdasd'),
          ),
        ),
      )
    );
  }

}