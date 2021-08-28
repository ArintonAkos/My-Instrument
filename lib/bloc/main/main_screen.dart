import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPageIndex = 0;

  void _changePageIndex(int id) {
    if (id  != _selectedPageIndex) {
      if (id == 0) {
        Modular.to.navigate('/home/');
      } else if (id == 1) {
        Modular.to.navigate('/home/favorites');
      } else if (id == 2) {
        Modular.to.navigate('/home/new-listing');
      } else if (id == 3) {
        Modular.to.navigate('/home/messages');
      } else if (id == 4) {
        Modular.to.navigate('/home/profile');
      }
      setState(() {
        _selectedPageIndex = id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: SafeArea(
        child: RouterOutlet(),
      ),
      bottomNavigationBar:
        CustomNavigationBar(
          iconSize: 20.0,
          selectedColor: Theme.of(context).colorScheme.onSurface,
          strokeColor: Theme.of(context).colorScheme.onSurface,
          unSelectedColor: Colors.grey[600],
          backgroundColor: Theme.of(context).colorScheme.surface,
          currentIndex: _selectedPageIndex,
          onTap: _changePageIndex,
          items: <CustomNavigationBarItem>[
            CustomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home),
            ),
            CustomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.heart),
            ),
            CustomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.plus),
            ),
            CustomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.comments),
            ),
            CustomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
            ),
          ],
        )

    );
  }

}