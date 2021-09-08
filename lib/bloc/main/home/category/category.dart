import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_instrument/models/category.dart';

class CategoryPage extends StatelessWidget {
  final Category model;
  CategoryPage({
    required this.model
  });

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
              Modular.to.pushNamed('/category', arguments: Category(category: 'Asd123', parentCategory: 'Lol123'));
            },
            child: Text(
              'Menj at az Asd123-ra'
            ),
          ),
        ),
      )
    );
  }


}