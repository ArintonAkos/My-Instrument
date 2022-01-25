import 'package:flutter/material.dart';
import 'package:my_instrument/models/category.dart';

class CategoryPage extends StatelessWidget {
  final Category model;

  const CategoryPage({Key? key,
    required this.model
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            model.category
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.green,
          child: TextButton(
            onPressed: () {
              /*Modular.to.pushNamed(
                '/category',
                arguments: Category(
                  category: 'Asd123',
                  parentCategory: 'Lol123'
                )
              );*/
            },
            child: const Text(
              'Menj at az Asd123-ra'
            ),
          ),
        ),
      )
    );
  }


}