import 'package:flutter/material.dart';

class ListingPage extends StatelessWidget {
  final String id;

  const ListingPage({
    Key? key,
    required this.id
  }) : super(key: key);

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
            child: const Text('asdasd'),
          ),
        ),
      )
    );
  }

}