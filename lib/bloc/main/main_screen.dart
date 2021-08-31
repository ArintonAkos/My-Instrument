import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';
import 'package:line_icons/line_icons.dart';

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
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                gap: 6,
                activeColor: Theme.of(context).colorScheme.onSurface,
                iconSize: 20,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.heart,
                    text: 'Favorites',
                  ),
                  GButton(
                      icon: LineIcons.plus,
                      text: 'Create'
                  ),
                  GButton(
                    icon: LineIcons.commentsAlt,
                    text: 'Messages',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedPageIndex,
                onTabChange: _changePageIndex
              ),
            )
          )
      )
    );
  }

}