import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
  return AutoTabsScaffold(
      routes: [],
      extendBody: true,
      builder: (context, child, animation) => SafeArea(
          child: PageTransitionSwitcher(
              transitionBuilder: (animChild, primaryAnimation,
                  secondaryAnimation) =>
                  FadeThroughTransition(
                      animation: primaryAnimation,
                      secondaryAnimation: secondaryAnimation,
                      child: animChild
                  ),
              child: child
          )
      ),
      bottomNavigationBuilder: (_,  tabsRouter) {
        return CustomNavigationBar(
          iconSize: 20.0,
          selectedColor: Theme.of(context).colorScheme.onSurface,
          strokeColor: Theme.of(context).colorScheme.onSurface,
          currentIndex: tabsRouter.activeIndex,
          unSelectedColor: Colors.grey[600],
          backgroundColor: Theme.of(context).colorScheme.surface,
          onTap: tabsRouter.setActiveIndex,
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
        );
      }
    );
  }

}